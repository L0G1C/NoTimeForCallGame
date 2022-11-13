extends Node

onready var plus_sfx = load("res://Assets/Audio/SFX/plus-resource.wav")
onready var minus_sfx = load("res://Assets/Audio/SFX/minus-resource.wav")

func _ready():
	$MusicStreamPlayer.play()


func play_resource_effect():
	$AudioStreamPlayer.set_stream(plus_sfx)
	$AudioStreamPlayer.play()
