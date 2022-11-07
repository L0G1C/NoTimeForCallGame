extends Node2D

const NEXT_DIALOG_RATE = 1

onready var dialog_countdown_timer = 0
onready var rng = RandomNumberGenerator.new()
var call_sequence_data : Dictionary
var call_sequence_event_tracker : Dictionary
var NoTimeSequence = preload("res://Resources/Call Sequences/NoThyme.tres")
var CallDialog = preload("res://Scenes/Game/CallDialog.tscn");
var GameOverScreen = preload("res://Scenes/Game/UI/GameOver.tscn")

func _ready():		
	call_sequence_data[NoTimeSequence.sequence_id] =  NoTimeSequence
	call_sequence_event_tracker[NoTimeSequence.sequence_id] = 0	
	
func _process(delta):
	dialog_countdown_timer += delta
	if dialog_countdown_timer >= NEXT_DIALOG_RATE:		
		dialog_countdown_timer = 0
		popup_random_call_sequence()
	

func popup_random_call_sequence():
	# Have to use RNG for randi_range
	rng.randomize()
	var random_call_sequence = rng.randi_range(0, call_sequence_data.size() - 1)		
	var call_sequence = call_sequence_data[random_call_sequence]
	var eventToShow = call_sequence_event_tracker[call_sequence.sequence_id]
	
	# Probably need to stop trying to load higher events.
	if eventToShow >= call_sequence["Events"].size():
		eventToShow = call_sequence["Events"].size() - 1
	
	var eventDict = call_sequence["Events"][eventToShow]	
	call_sequence_event_tracker[call_sequence.sequence_id] += 1 #increment event index for next time.
	
	# construct Dialog
	construct_dialog(eventDict, call_sequence["color"])

func construct_dialog(eventDict, color):
	var dialog = CallDialog.instance()
	dialog.get_ok().visible = false
	dialog.get_close_button().visible = false
	dialog.window_title = eventDict["CallerName"]
	dialog.dialog_text = eventDict["Text"]
	dialog.add_button(eventDict["CorrectAnswerText"], false, "correct")
	dialog.add_button(eventDict["WrongAnswerText"], false, "wrong")
	dialog.correct_results = eventDict["CorrectAnswerResults"]
	dialog.wrong_results = eventDict["WrongAnswerResults"]
	dialog.modulate = Color(color)
	dialog.connect("success", self, "dialog_success")
	dialog.connect("fail", self, "dialog_fail")
	if eventDict["CallerName"] == "Cal":
		dialog.iscal = true
	$Dialogs.add_child(dialog)
	
	# setting random position and using show() instead of popup() so that we can interact with other popups
	# but not auto-hide the popup when clicked outside
	dialog.set_position(Vector2(rand_range(100, 400), rand_range(100, 400)))
	dialog.show() 
		
	dialog.connect("custom_action", dialog, "handle_dialog_buttons")
	
func game_over(player_won):
	var game_over = GameOverScreen.instance()
	game_over.sub_title = "You survived!"
	if player_won == "cal":
		game_over.sub_title = "NO THYME FOR CAL!"
	if player_won == "money":
		game_over.sub_title = "HAHA you're a broke mofo now :)"
	if player_won == "family":
		game_over.sub_title = "Lol, you neglected your family, what a great spouse/parent you are XD"
	if player_won == "sanity":
		game_over.sub_title = "You lost all the sanity you hade left, oh well... Asylums are cozy... Right?"
	$CanvasLayer.add_child(game_over)
	get_tree().paused = true

func dialog_success(results_array):
	$CanvasLayer/WorkLifeContainer/Resources/Money/ProgressBar.value += results_array[0]
	$CanvasLayer/WorkLifeContainer/Resources/Family/ProgressBar.value += results_array[1]
	$CanvasLayer/WorkLifeContainer/Resources/Sanity/ProgressBar.value += results_array[2]
	
func dialog_fail(results_array, iscal):
	$CanvasLayer/WorkLifeContainer/Resources/Money/ProgressBar.value += results_array[0]
	$CanvasLayer/WorkLifeContainer/Resources/Family/ProgressBar.value += results_array[1]
	$CanvasLayer/WorkLifeContainer/Resources/Sanity/ProgressBar.value += results_array[2]
	if iscal:
		game_over("cal")


func _on_Money_resource_empty():
	game_over("money")


func _on_Family_resource_empty():
	game_over("family")


func _on_Sanity_resource_empty():
	game_over("sanity")
