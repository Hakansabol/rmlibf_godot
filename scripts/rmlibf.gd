class_name Rmlibf

static func format_time_hhmmss_from_seconds(seconds: float) -> String:
	var s = ("0" + str(int(fmod(seconds , 1.0) * 100)))
	var s2 = ("0" + str(int(fmod(seconds , 60.0))))
	return str(int(seconds / 60.)) + ":" + s2.substr(len(s2)-2,2) + "." + s.substr(len(s)-2,2)
