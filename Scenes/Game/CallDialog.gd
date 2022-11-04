extends AcceptDialog

var progress_timeout = false
onready var pBar = $BackgroundPanel/VBoxContainer/ProgressBar

func _ready():
	pass # Replace with function body.

func _process(delta):
	pBar.get_node(("Label")).text = String(pBar.value)

func _on_ProgressTimer_timeout():
		if pBar.value > 0:
			pBar.value -= 1
		else:
			self.hide()
			# TODO -  Call Game Manager failure
			queue_free()
