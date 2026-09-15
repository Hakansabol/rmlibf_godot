extends Control
class_name Hoverable

## A simple [c]omponent-style hoverable object.
## mouse-enter and -exit events show and hide a tooltip.
## Recommend to enable 'Propagate up' mouse behavior.

## The text to display in the hoverable
@export_multiline var bbcode: String
signal _on_hovered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)


var popup: RmlPopup = null
func _on_mouse_entered():
	_on_hovered.emit()
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
