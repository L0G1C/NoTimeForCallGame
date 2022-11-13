extends VBoxContainer

export(String, "Money", "Family", "Sanity") var ResourceType

signal resource_empty

func _ready():
	$ProgressBar.value = 5
	
	match (ResourceType):
		"Money":
			$Label.text = "Money"
			$ProgressBar.modulate = Color("c1e1c1")
		"Family":
			$Label.text = "Family"
			$ProgressBar.modulate = Color("ffa07a")
		"Sanity":
			$Label.text = "Sanity"
			$ProgressBar.modulate = Color("9adfff")

func _process(_delta):
	if $ProgressBar.value == 0:
		emit_signal("resource_empty")
		
func _on_plus_anim_complete():
	$Plus.modulate = Color(1, 1, 1, 0)
	
func _on_mius_anim_complete():
	$Minus.modulate = Color(1, 1, 1, 0)
	
