@icon("res://rmlibf_godot/editor_assets/rml_asset_entity.png")
extends CollisionObject2D
class_name RmlEntity

func get_scene_root() -> Node:
	return get_tree().root.get_child(1)
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

enum Team {
	Player = 1,
	Enemy = 2,
	Ally = 4,
	Neutral = 8
}

@export var MAX_HEALTH: int
@export var current_health: int

func _ready() -> void:
	current_health = MAX_HEALTH

func _damage(health: int):
	current_health -= health

	if current_health <= 0:
		_on_death()

func _on_death():
	queue_free()
