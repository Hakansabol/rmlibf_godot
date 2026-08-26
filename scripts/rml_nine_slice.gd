@tool
extends NinePatchRect
## Simple extension of NinePatchRect allowing it to work on non-UI objects like terrain.
## Optimized for simplicity, not performance.

@export var base_size: Vector2 = Vector2(100, 100)
@export var zoom_factor: float = 1.0
var parent_body: StaticBody2D
func _ready():
	collect_parent()

func collect_parent() -> void:
	parent_body = get_parent() as StaticBody2D
	if not parent_body:
		printerr(name + "- err: rml_proj_static does not support changing the parent's type!")

func _process(_delta: float) -> void:
	if not parent_body:
		collect_parent()
	var parent_scale = parent_body.global_scale
	scale = Vector2(1 / parent_scale.x * zoom_factor, 1 / parent_scale.y * zoom_factor) # invert the scale: normalize it to 1,1
	size = Vector2(base_size.x * parent_scale.x / zoom_factor, base_size.y * parent_scale.y / zoom_factor)
