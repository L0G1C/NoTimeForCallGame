extends VBoxContainer

export(String, "Money", "Family", "Sanity") var ResourceType

signal resource_empty

func _ready():
	$ProgressBar.value = 5
	
	match (ResourceType):
		"Money":
			$Label.text = "Money"
			$ProgressBar.modulate = Color(0,1,0)
		"Family":
			$Label.text = "Family"
			$ProgressBar.modulate = Color(0,0,1)
		"Sanity":
			$Label.text = "Sanity"
			$ProgressBar.modulate = Color(1,0,0)

func _process(_delta):
	if $ProgressBar.value == 0:
		emit_signal("resource_empty")
