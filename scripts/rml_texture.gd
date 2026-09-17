extends TextureRect
class_name RmlTexture

## Extension of TextureRect that facilitates simple visual effects.
## Note: This class makes the scale of the object immutable.


var pulse_amount: float = 0.0
## TODO: Not implemented.
func effect_pulse(strength: float = 0.3):
	pulse_amount += strength
func _update_effect_pulse(delta: float):
	shake_amount -= delta * 0.2
func _update_effect_pulse_fixedtime(_delta: float):
	pulse_amount *= 0.98

var shake_amount: float = 0.0
## Add a `shake` effect to shake the object instantly.
func effect_shake(strength: float = 0.5):
	print(strength)
	shake_amount += strength
func _update_effect_shake(delta: float):
	shake_amount = Rmlibf.elerp(shake_amount, 0, 0.95, delta)
	shake_amount = max(0, shake_amount - 1.2 * delta)

var static_size: float = 1.0
const SIZE_CHANGE_SPEED = 0.4
## Set the default size of the object.
func set_static_size_multiplier(target_size: float):
	static_size = target_size

var offset_position: Vector2 = Vector2(0, 0)
func apply_effects(_delta: float) -> void:
	position -= offset_position
	offset_position = Vector2(randf_range(-shake_amount,shake_amount), randf_range(-shake_amount,shake_amount))
	position += offset_position

	scale = Vector2(static_size+pulse_amount,static_size+ pulse_amount)

func update_effects(delta: float) -> void:
	_update_effect_pulse(delta)
	_update_effect_shake(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_effects(delta)
	apply_effects(delta)
