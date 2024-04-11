extends Label


var time_seconds = 0

func format_time(seconds):
	# Format the time into MM:SS format
	var minutes = int(seconds / 60)
	var seconds_remainder = int(seconds % 60)
	return String("%02d:%02d" % [minutes, seconds_remainder])
	



func _on_Timer_timeout():
	time_seconds += 1
	text = format_time(time_seconds)
	pass # Replace with function body.
