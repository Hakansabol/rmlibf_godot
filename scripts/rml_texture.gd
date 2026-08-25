extends TextureRect
class_name RmlTexture

## Extension of TextureRect that facilitates simple visual effects.
## Note: This class makes the scale of the object immutable.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	apply_effects(delta)

var pulse_amount: float = 0.0
func effect_pulse(strength: float = 0.3):
	pulse_amount += strength
func _update_effect_pulse(delta: float):
	pulse_amount *= 0.98

var shake_amount: float = 0.0
func effect_shake(strength: float = 0.5):
	shake_amount += strength
func _update_effect_shake(delta: float):
	shake_amount *= 0.98


var offset_position: Vector2 = Vector2(0, 0)
func apply_effects(delta: float) -> void:
	position -= offset_position
	offset_position = Vector2(randf_range(-shake,shake), randf_range(-shake,shake))
