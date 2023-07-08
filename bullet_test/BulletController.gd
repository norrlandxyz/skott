extends Node2D
signal switch()

func _input(event):
	if event.is_action_pressed("switch"):
		emit_signal("switch")

