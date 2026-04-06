extends RichTextLabel
class_name SpeedrunTimer

var running: bool = true
var t: float = 0.0

func _ready() -> void:
	GameManager.timer = self

func _process(delta: float) -> void:
	if running:
		t += delta
	var s = ("0" + str(int(fmod(t , 1.0) * 100)))
	var s2 = ("0" + str(int(fmod(t , 60.0))))
	(self as RichTextLabel).text = str(int(t / 60.)) + ":" + s2.substr(len(s2)-2,2) + "." + s.substr(len(s)-2,2)
