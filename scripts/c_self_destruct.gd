extends Node
class_name RmlSelfDestruct

@export var remaining_life: float = 5.0
func _process(delta: float) -> void:
	remaining_life -= delta
	if remaining_life < 0:
		get_parent().queue_free()
