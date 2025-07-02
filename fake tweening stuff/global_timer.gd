extends Timer

var minutes = 0

func t():
	return 60-time_left + minutes*60

func _on_timeout() -> void:
	minutes+=1
