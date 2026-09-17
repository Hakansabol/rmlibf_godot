extends Control
class_name Hoverable

## A simple [c]omponent-style hoverable object.
## mouse-enter and -exit events show and hide a tooltip.
## Recommend to enable 'Propagate up' mouse behavior.

## The text to display in the hoverable
@export_multiline var bbcode: String
## Whether or not game_manager.gd should let this object be dragged by the mouse cursor
@export var draggable: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)


var popup: RmlPopup = null
func _on_mouse_entered():
	if not popup:
		popup = GameManager.popup.instantiate()
		popup.TextObject.bbcode = bbcode
		get_tree().root.add_child(popup)

func _on_mouse_exited():
	if popup:
		popup.destroy()
		popup = null

func _exit_tree() -> void:
	if popup:
		popup.destroy()

func _on_start_dragging():
	pass
func _on_end_dragging():
	pass
func _on_while_dragging():
	get_parent().global_position = GameManager.get_mouse_position() - get_parent_area_size() * 0.5
func _on_clicked():
	pass
