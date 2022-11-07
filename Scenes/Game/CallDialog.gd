extends AcceptDialog

var progress_timeout = false
var correct_results : Array
var wrong_results : Array
onready var pBar = $BackgroundPanel/VBoxContainer/ProgressBar

signal success
signal fail

var iscal = false;

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pBar.get_node(("Label")).text = String(pBar.value)

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
