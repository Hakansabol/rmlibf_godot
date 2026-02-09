extends Camera2D
class_name RmlCamera

@export
var effects: Array = []

class smoothing_effect:
	var effect_name: String
	var smoothing_type: String # static, pulse, decay
	var strength: float
	var time: float
	var time_elapsed: float

	func _init(n: String, t: String, str: float, time: float) -> void:
		self.effect_name = n
		self.smoothing_type = t
		self.strength = str
		self.time = time
		self.time_elapsed = 0


func shake(strength: float):
	effects.push_back(smoothing_effect.new("shake", "pulse", strength, 5))

func _ready() -> void:
	game_manager.camera = self

var last_displacement: Vector2 = Vector2(0, 0)
func _process(delta: float) -> void:
	var shake: float = 0

	# push all the numbers into the effects
	print(effects.size())
	for i in range(effects.size()-1, -1, -1):
		var eff: smoothing_effect = effects[i] as smoothing_effect
		var value: float = 0

		if eff.smoothing_type == "pulse":
			value = eff.strength * pow(0.9, (eff.time_elapsed / eff.time) * 500)

		if eff.effect_name == "shake":
			shake += value
		else:
			print("bad effect name")

		if eff.time_elapsed > eff.time:
			effects.pop_at(i)

		eff.time_elapsed += delta
	
	# apply all the effects
	var new_displacement: Vector2 = Vector2(randf_range(-shake,shake), randf_range(-shake,shake))
	global_position = global_position - last_displacement + new_displacement
	last_displacement = new_displacement
