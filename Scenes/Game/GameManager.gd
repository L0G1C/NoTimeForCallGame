extends Node2D

onready var rng = RandomNumberGenerator.new()

const NEXT_DIALOG_RATE = 0.88
var time_score = 0
var call_sequence_data : Dictionary
var call_sequence_event_tracker : Dictionary
var NoTimeSequence = preload("res://Resources/Call Sequences/NoThyme.tres")
var BossSequence = preload("res://Resources/Call Sequences/Boss.tres")
var SpouseSequence = preload("res://Resources/Call Sequences/Spouse.tres")
var PrincipalSequence = preload("res://Resources/Call Sequences/Principal.tres")
var TelemarketersSequence = preload("res://Resources/Call Sequences/Telemarketers.tres")
var CallDialog = preload("res://Scenes/Game/CallDialog.tscn");
var GameOverScreen = preload("res://Scenes/Game/UI/GameOver.tscn")

func _ready():
	SoundManager.start_game_music()
	call_sequence_data[NoTimeSequence.sequence_id] =  NoTimeSequence
	call_sequence_data[BossSequence.sequence_id] =  BossSequence
	call_sequence_data[SpouseSequence.sequence_id] =  SpouseSequence
	call_sequence_data[PrincipalSequence.sequence_id] =  PrincipalSequence
	call_sequence_data[TelemarketersSequence.sequence_id] =  TelemarketersSequence
	
	call_sequence_event_tracker[NoTimeSequence.sequence_id] = 0
	call_sequence_event_tracker[BossSequence.sequence_id] = 0
	call_sequence_event_tracker[SpouseSequence.sequence_id] = 0
	call_sequence_event_tracker[PrincipalSequence.sequence_id] = 0
	call_sequence_event_tracker[TelemarketersSequence.sequence_id] = 0
	
func _process(delta):
	$CanvasLayer/Panel/HBoxContainer/ScoreText.text = String(time_score)
	

func popup_random_call_sequence():
	print("Call Sequences")
	for c in call_sequence_data.keys():
		print("sequence: %s" % call_sequence_data[c].sequence_id)
	
	# if the only call sequence left is Cal, Game Over!
	if call_sequence_data.size() == 1:		
		game_over("")

	# Have to use RNG for randi_range
	rng.randomize()
	# only include Cal call in the pool 4/5 times.
	var includeCal = rng.randi_range(1, 5)
	var random_call_sequence
	if includeCal > 1:
		random_call_sequence = rng.randi_range(0, call_sequence_data.size() - 1)
	else:
		random_call_sequence = rng.randi_range(1, call_sequence_data.size() - 1)
	
	# back out if the squence has already been removed 
	if !call_sequence_data.keys().has(random_call_sequence):
		return
	
	var call_sequenceid = call_sequence_data.keys()[random_call_sequence]
	var call_sequence = call_sequence_data[call_sequenceid]
	var eventToShow = call_sequence_event_tracker[call_sequence.sequence_id]
	
	
	# When Maxed Events reached, remove that sequence
	if eventToShow >= call_sequence["Events"].size():
		# Always show Cal's last message
		if call_sequence["Events"][0]["CallerName"] == "Cal":
			eventToShow = call_sequence["Events"].size() - 1
		else:
			call_sequence_data.erase(call_sequence.sequence_id)
			return
	
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
	dialog.caller_voice = eventDict["CallerVoice"]
	dialog.add_button(eventDict["CorrectAnswerText"], false, "correct")
	dialog.add_button(eventDict["WrongAnswerText"], false, "wrong")
	dialog.correct_results = eventDict["CorrectAnswerResults"]
	dialog.wrong_results = eventDict["WrongAnswerResults"]
	dialog.modulate = Color(color)
	dialog.connect("success", self, "dialog_success")
	dialog.connect("fail", self, "dialog_fail")
	if eventDict["CallerName"] == "Cal":
		dialog.iscal = true
	dialog.animate_dialog()
	$Dialogs.add_child(dialog)
	
	
	# setting random position and using show() instead of popup() so that we can interact with other popups
	# but not auto-hide the popup when clicked outside
	dialog.set_position(Vector2(rand_range(100, 400), rand_range(100, 400)))
	dialog.show() 
		
	dialog.connect("custom_action", dialog, "handle_dialog_buttons")
	
func game_over(player_won):
	var game_over = GameOverScreen.instance()
	game_over.sub_title = "You survived!"
	game_over.time_lived = String(time_score)
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
	
	#Display Results Icon and play sound depending on positive or negative results
	$CanvasLayer/WorkLifeContainer/Resources/Money/ProgressBar.value += results_array[0]
	if results_array[0] > 0:
		$CanvasLayer/WorkLifeContainer/Resources/Money/AnimationPlayer.play("Plus Float")		
	else: 
		$CanvasLayer/WorkLifeContainer/Resources/Money/AnimationPlayer.play("Minus Float")		
		
	$CanvasLayer/WorkLifeContainer/Resources/Family/ProgressBar.value += results_array[1]
	if results_array[1] > 0:
		$CanvasLayer/WorkLifeContainer/Resources/Family/AnimationPlayer.play("Plus Float")		
	else: 
		$CanvasLayer/WorkLifeContainer/Resources/Family/AnimationPlayer.play("Minus Float")		
	
	$CanvasLayer/WorkLifeContainer/Resources/Sanity/ProgressBar.value += results_array[2]
	if results_array[2] > 0:
		$CanvasLayer/WorkLifeContainer/Resources/Sanity/AnimationPlayer.play("Plus Float")		
	else: 
		$CanvasLayer/WorkLifeContainer/Resources/Sanity/AnimationPlayer.play("Minus Float")		
		
	SoundManager.play_resource_effect()
	
func dialog_fail(results_array, iscal):
	#Display Results Icon and play sound depending on positive or negative results
	$CanvasLayer/WorkLifeContainer/Resources/Money/ProgressBar.value += results_array[0]
	if results_array[0] > 0:
		$CanvasLayer/WorkLifeContainer/Resources/Money/AnimationPlayer.play("Plus Float")		
	else: 
		$CanvasLayer/WorkLifeContainer/Resources/Money/AnimationPlayer.play("Minus Float")
		
	$CanvasLayer/WorkLifeContainer/Resources/Family/ProgressBar.value += results_array[1]
	if results_array[1] > 0:
		$CanvasLayer/WorkLifeContainer/Resources/Family/AnimationPlayer.play("Plus Float")
	else: 
		$CanvasLayer/WorkLifeContainer/Resources/Family/AnimationPlayer.play("Minus Float")
	
	$CanvasLayer/WorkLifeContainer/Resources/Sanity/ProgressBar.value += results_array[2]
	if results_array[2] > 0:
		$CanvasLayer/WorkLifeContainer/Resources/Sanity/AnimationPlayer.play("Plus Float")
	else: 
		$CanvasLayer/WorkLifeContainer/Resources/Sanity/AnimationPlayer.play("Minus Float")
	if iscal:
		game_over("cal")
	SoundManager.play_resource_effect()

func _on_Money_resource_empty():
	game_over("money")


func _on_Family_resource_empty():
	game_over("family")


func _on_Sanity_resource_empty():
	game_over("sanity")


func _on_GameTimer_timeout():
	popup_random_call_sequence()
	if $GameTimer.wait_time >= 0.5:
		$GameTimer.wait_time = $GameTimer.wait_time * NEXT_DIALOG_RATE	
	
	$GameTimer.start()
	SoundManager.speed_up()
	
func _on_ScoreTimer_timeout():
	time_score += 1
