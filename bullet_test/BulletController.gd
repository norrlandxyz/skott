extends Node2D

signal on()

var bullet = 0
var oldBullet
var currentBullet = null
#var bullet_id = null

var bullet_switch_in_array = 0

func pickCurrentBullet(bullet):
	unPickCurrentBullet()
	bullet.start_controlls()
	currentBullet = bullet
	#bullet_id = bullet.bullet_id

func unPickCurrentBullet():
	if is_instance_valid(currentBullet):
		currentBullet.stop_controlls()

func _process(delta):
	var bullets = get_tree().get_nodes_in_group("bullet")
	
	if !bullets.is_empty():
		#if current bullet does not exist, change it to the first bullet
		if currentBullet == null or is_instance_valid(currentBullet) == false:
			pickCurrentBullet(bullets[0])
			bullet_switch_in_array = 0
		elif bullet_switch_in_array > 0:
			if bullets.size()-1 < bullet_switch_in_array:
				bullet_switch_in_array = 0
			if is_instance_valid(bullets[bullet_switch_in_array]):
				if is_instance_valid(currentBullet):
					currentBullet.stop_controlls
				pickCurrentBullet(bullets[bullet_switch_in_array])
	#for bullet in bullets:
	#	bullet.testtext = "retard"
	
	#if bullets.size() == bullet:
	#	bullet = 0
	
	#if bullets.size() > 1:
	#	currentBullet = bullets[bullet]
	
	#	if currentBullet == null:
	#		bullet = 0
	#		switchbullet()
	#		
	#	if currentBullet != oldBullet:
	#		switchbullet()

func _input(event):
	if event.is_action_pressed("switch"):
		bullet_switch_in_array += 1
		#var bullets = get_tree().get_nodes_in_group("bullet")
		#if bullets.size() > bullet:
		#	bullet = bullet+1
		#	
		#if bullets.size() == bullet:
		#	bullet = 0
		
		#switchbullet()
	
#func switchbullet():
	#emit_signal("on", bullet)
	#var bullets = get_tree().get_nodes_in_group("bullet")
	#oldBullet = bullets[bullet]
