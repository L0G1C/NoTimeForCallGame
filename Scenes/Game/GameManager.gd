extends Node2D

const NEXT_DIALOG_RATE = 5

onready var dialog_countdown_timer = 0
onready var rng = RandomNumberGenerator.new()
var call_sequence_data : Dictionary
var call_sequence_event_tracker : Dictionary
var NoTimeSequence = preload("res://Resources/Call Sequences/NoThyme.tres")
var CallDialog = preload("res://Scenes/Game/CallDialog.tscn");



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
	print("Random Call Sequence at index %s" % random_call_sequence)
	
	var call_sequence = call_sequence_data[random_call_sequence]
	var eventToShow = call_sequence_event_tracker[call_sequence.sequence_id]
	
	# Probably need to stop trying to load higher events.
	if eventToShow >= call_sequence["Events"].size():
		eventToShow = call_sequence["Events"].size() - 1
	
	var eventDict = call_sequence["Events"][eventToShow]
	print("Event: %s" % eventDict["EventId"] )
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
	dialog.modulate = Color(color)
	$Dialogs.add_child(dialog)
	
	# setting random position and using show() instead of popup() so that we can interact with other popups
	# but not auto-hide the popup when clicked outside
	dialog.set_position(Vector2(rand_range(100, 400), rand_range(100, 400)))
	dialog.show() 
		
	# TODO - Connect Signals for BTN clicks
	dialog.connect("custom_action", dialog, "handle_dialog_buttons")

