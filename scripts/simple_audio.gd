extends AudioStreamPlayer2D
class_name RmlAudio

@export var audio_clips: Array[AudioStream] = []
@export var pitch_randomization: float = 0.15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func play_rml():
	stream = audio_clips.pick_random()
	pitch_scale = randf_range(1 - pitch_randomization, 1 + pitch_randomization)
	play()
