extends RmlProjectile
class_name RmlProjectileLinear

@export var acceleration: Vector2
var velocity: Vector2
var lifetime: float
var delay: float
func initialize(src: RmlEntity, vel: Vector2, life: float, del: float = 0):
	velocity = vel
	lifetime = life
	delay = del

func _physics_process(delta: float) -> void:
	lifetime -= delta
	if delay > 0:
		delay -= delta
		return

	position += velocity * delta
	if lifetime < 0:
		queue_free()
