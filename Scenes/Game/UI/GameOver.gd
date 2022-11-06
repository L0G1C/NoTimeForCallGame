extends Control

var game_over_music = load("res://Assets/Audio/game_over.wav")
var sub_title

func _ready():
	$SoundManager/AudioStreamPlayer.stream = game_over_music
	$SoundManager/AudioStreamPlayer.play()
	$Panel/MarginContainer/TitleRow/SubTitle.text = sub_title

func _on_RestartBtn_pressed():
	SceneLoader.load_scene("res://Scenes/Game/Game.tscn")


func _on_QuitBtn_pressed():
	SceneLoader.load_scene("res://Scenes/MainMenu/MainMenu.tscn")
