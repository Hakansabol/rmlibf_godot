class_name Rmlibf

## Global script containing helper functions usable throughout the project

## Format time into hhmmss
static func format_time_hhmmss_from_seconds(seconds: float) -> String:
	var s = ("0" + str(int(fmod(seconds , 1.0) * 100)))
	var s2 = ("0" + str(int(fmod(seconds , 60.0))))
	return str(int(seconds / 60.)) + ":" + s2.substr(len(s2)-2,2) + "." + s.substr(len(s)-2,2)

## Exponential lerp on deltatime
## if `to == 0`, the lerp is exponential decay.
## `speed` is per second, so 0.9 means the lerp will travel 90% of the distance per delta==1.
static func elerp(from: float, to: float, speed: float, delta: float):
	return lerp(from, to, 1 - (1 - speed) ** delta)
