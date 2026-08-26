extends CenterContainer
class_name RmlPopup

## A simple popup that expands in and out of existence.
## Requires manual destruction.
##
## Displays simple RicherText.
## Visual properties set in inspector.


@export_group("Connections")
@export var TextObject: RicherTextLabel
@export var BackObject: NinePatchRect

@export_group("Variables")
@export var animation_length: float = 0.3
@export_group("")

## how long this object has been alive.
var alivetime: float = 0.0
## the time at which death will arrive
## freed when alivetime >= deathtime
var deathtime: float = 1800.0
var follow_mouse: bool = true

var max_size: float = 0.0
func _ready() -> void:
	alivetime = 0

	# setting the max size
	max_size = TextObject.size.y
	TextObject._updated.connect(_set_max_size)

func _set_max_size():
	max_size = TextObject.get_minimum_size().y

func override_position(pos: Vector2):
	global_position = pos
	follow_mouse = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# handle slide-in animation
	_alive_tick(delta)

	# handle destruction and slide-out animation
	_destruction_tick(delta)

	if follow_mouse:
		global_position = get_global_mouse_position() + Vector2(20, 0)

func _alive_tick(delta: float) -> void:
	alivetime += delta
	custom_maximum_size = Vector2(-1, max_size * min(1.0, alivetime / animation_length))

func _destruction_tick(_delta: float) -> void:
	var deathtime_anim_progress: float = animation_length - ( deathtime - alivetime)

	# not dying yet...
	if deathtime_anim_progress < 0:
		return

	# set the object size
	custom_maximum_size = Vector2(-1, max_size * min(1.0, (animation_length - deathtime_anim_progress) / animation_length))

	# destroy the object if it's been marked for death for time >= anim_length
	if alivetime >= deathtime:
		queue_free()

func destroy():
	TextObject.z_index -= 2
	if deathtime > alivetime + animation_length:
		deathtime = alivetime + animation_length
	else:
		print("warn minor: RmlPopup type destroyed twice")
