extends Control

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_file("res://menu/level_select.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://menu/settings.tscn")


func _on_exit_pressed():
	get_tree().quit()

