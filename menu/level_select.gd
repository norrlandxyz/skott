extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu/index.tscn")


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://level1/level1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://level2/level2.tscn")


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://level3/level3.tscn")


func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://level4/level4.tscn")
