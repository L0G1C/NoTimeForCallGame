extends Control

var game_over_music = load("res://Assets/Audio/Music/game_over.wav")
var sub_title
var time_lived

func _ready():
	$SoundManager/MusicStreamPlayer.stream = game_over_music
	$SoundManager/MusicStreamPlayer.play()
	$Panel/MarginContainer/TitleRow/SubTitle.text = sub_title
	$Panel/MarginContainer/TitleRow/TimeScore.text = "You survived for %s seconds!" % time_lived

func _on_RestartBtn_pressed():
	SceneLoader.load_scene("res://Scenes/Game/Game.tscn")


func _on_QuitBtn_pressed():
	SceneLoader.load_scene("res://Scenes/MainMenu/MainMenu.tscn")
