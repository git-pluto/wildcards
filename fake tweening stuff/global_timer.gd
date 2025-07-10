extends Timer

var minutes = 1 # starts at 1 and not at 0 to avoid comparing numbers that are too small and volitile

func t():
	return 60-time_left + minutes*60

func _on_timeout() -> void:
	minutes+=1
