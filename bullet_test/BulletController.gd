extends Node2D

signal on()

var bullet = 0
var oldBullet
var currentBullet

func _process(delta):
	var bullets = get_tree().get_nodes_in_group("bullet")
	
	if bullets.size() == bullet:
		bullet = 0
	
	if bullets.size() > 1:
		currentBullet = bullets[bullet]
	
		if currentBullet == null:
			bullet = 0
			switchbullet()
			
		if currentBullet != oldBullet:
			switchbullet()

func _input(event):
	if event.is_action_pressed("switch"):
		var bullets = get_tree().get_nodes_in_group("bullet")
		if bullets.size() > bullet:
			bullet = bullet+1
			
		if bullets.size() == bullet:
			bullet = 0
		
		switchbullet()
	
func switchbullet():
	emit_signal("on", bullet)
	var bullets = get_tree().get_nodes_in_group("bullet")
	oldBullet = bullets[bullet]
