extends Node2D

var enemies = null

var bullets
var big_bullets

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.is_empty():
		bullets = get_tree().get_nodes_in_group("bullet")
		big_bullets = get_tree().get_nodes_in_group("big_enemy_bullet")
		for bullet in bullets:
			bullet.queue_free()
		for big_bullet in big_bullets:
			big_bullet.queue_free()
		get_tree().paused = true
		get_tree().change_scene_to_file("res://menu/win.tscn")
