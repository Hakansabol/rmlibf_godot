extends RichTextLabel
class_name SpeedrunTimer

var running: bool = true
var t: float = 0.0

func _ready() -> void:
	GameManager.timer = self

func _process(delta: float) -> void:
	if running:
		t += delta
	(self as RichTextLabel).text = Rmlibf.format_time_hhmmss_from_seconds(t)
