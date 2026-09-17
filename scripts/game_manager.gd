extends Node

var popup = preload("res://scenes/rml/rml_tooltip.tscn")
var camera: RmlCamera

var card_manager: CardManager

func message(text: String):
	print("received unhandled message: " + text)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func get_hovered_object() -> Control:
	return get_viewport().gui_get_hovered_control()
func get_mouse_position() -> Vector2:
	return get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size * 0.5

###
### FUNCTIONS THAT HANDLE PROJECT-WIDE OBJECT DRAGGING.
### USED IN CONJUNCTION WITH `c_hoverable.gd` OBJECTS
###
func force_undrag():
	if _is_dragging:
		dragging_object._on_end_dragging()
		dragging_object = null
		_drag_select = false

var _is_dragging: bool :## if TRUE, an object is on the cursor and it is of type Hoverable
	get: return dragging_object and (dragging_object as Hoverable) and (dragging_object as Hoverable).draggable
var _drag_select: bool = false ## if TRUE, drag type is `SELECT`, or "click and click". otherwise, it's assumed to be `DRAG`, or "click and release"
var __drag_start: Vector2 = Vector2.ZERO
var dragging_object: Hoverable = null

func _process(_delta: float) -> void:
	_do_draggable()

func _do_draggable():
	if Input.is_action_just_pressed("lmb"):
		# deselect any currently dragged objects
		if _is_dragging and _drag_select: 
			force_undrag()
		# select a new dragged object.
		else: 
			var hovered = get_hovered_object()
			if hovered and (hovered as Hoverable):
				dragging_object = hovered as Hoverable
				__drag_start = get_mouse_position()


	if _is_dragging:
		(dragging_object as Hoverable)._on_while_dragging()


	if Input.is_action_just_released("lmb"):
		if _is_dragging and (get_mouse_position() - __drag_start).length() < 10.0:
			_drag_select = true # click
		else:
			force_undrag() # drag
	pass
