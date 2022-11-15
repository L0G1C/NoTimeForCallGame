extends Node

onready var game_music = preload("res://Assets/Audio/Music/game_music.wav")
onready var title_music = preload("res://Assets/Audio/Music/title.wav")
onready var plus_sfx = preload("res://Assets/Audio/SFX/plus-resource.wav")
onready var minus_sfx = preload("res://Assets/Audio/SFX/minus-resource.wav")
onready var ring_sfx = preload("res://Assets/Audio/SFX/ring.wav")
onready var voice1 = preload("res://Assets/Audio/Voices/voice1-short.wav")
onready var voice2 = preload("res://Assets/Audio/Voices/voice2-short.wav")
onready var voice3 = preload("res://Assets/Audio/Voices/voice3-short.wav")


func _ready():
	pass

func start_game_music():
	$MusicStreamPlayer.set_stream(game_music)
	$MusicStreamPlayer.play()

func start_title_music():
	$MusicStreamPlayer.set_stream(title_music)
	$MusicStreamPlayer.play()

func play_resource_effect():
	$AudioStreamPlayer.set_stream(plus_sfx)
	$AudioStreamPlayer.play()
	
func play_ring():
	$AudioStreamPlayer.set_stream(ring_sfx)
	$AudioStreamPlayer.play()

func play_voice(array_size, voice):
	$VoicePlayer.stop()
	match(voice):
		"voice1":
			$VoicePlayer.set_stream(voice1)
		"voice2":
			$VoicePlayer.set_stream(voice2)
		"voice3":
			$VoicePlayer.set_stream(voice3)
	
	var sound_counter = 0
	var dialog_length = array_size / 5
	
	while sound_counter < dialog_length:
		$VoicePlayer.play()
		yield($VoicePlayer, "finished")
		sound_counter += 1
	
func speed_up():
	$MusicStreamPlayer.pitch_scale += 0.01
	

