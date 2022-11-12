extends AcceptDialog

var progress_timeout = false
var correct_results : Array
var wrong_results : Array
var text_to_animate = []
var animate_text_counter = 0
var animate_text = false
onready var pBar = $BackgroundPanel/VBoxContainer/ProgressBar

signal success
signal fail

var iscal = false;

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pBar.get_node(("Label")).text = String(pBar.value)	
	if animate_text and animate_text_counter < text_to_animate.size():
		dialog_text += text_to_animate[animate_text_counter]
		animate_text_counter += 1
	
func animate_dialog():
	for c in dialog_text:
		text_to_animate.append(c)
	self.dialog_text = ""
	animate_text = true

func _on_ProgressTimer_timeout():
		if pBar.value > 0:
			pBar.value -= 1
		else:
			self.hide()
			emit_signal("fail", wrong_results, false)
			queue_free()
			
func handle_dialog_buttons(action):
	match (action):
		"correct":
			emit_signal("success", correct_results)
			self.hide()
			self.queue_free()
		"wrong":
			emit_signal("fail", wrong_results, iscal)
			self.hide()
			self.queue_free()
