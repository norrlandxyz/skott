extends CharacterBody2D

const SPEED = 100.0
var location = randomLocation(1000, 0, 600, 0)

var rotation_weight = 1
var rotation_speed = PI
@export var rotation_direction = 0

@export var health = 100
@onready var health_bar = $"../Health"


@onready var timer = $Timer
var loadBullet = preload("res://bullet_test/bullet/bullet.tscn")

@onready var gun_pos = $GunPos
@onready var start_search_for_bullets_timer = $startSearchForBulletsTimer
@export var start_search_for_bullets = false;

var bullet_id = 1


func _ready():
	#spawn_bullet()
	health_bar.max_value = health
	health_bar.value = health
	timer.start()
	start_search_for_bullets_timer.start()

func _physics_process(delta):
	#rotation
	randomRotation(delta)
	
	#walk around
	#print(global_position.distance_to(location))
	#print(location)
	var velocity = (location - global_position).normalized() * SPEED
	move_and_collide(velocity * delta)
	if global_position.distance_to(location) < 200:
		location = randomLocation(1000, 0, 600, 0)
	
	#otherwise bullets will start spawning before the player has had a chance to move,
	#will result in weird bullet spawning behaviour
	if start_search_for_bullets == true:
		searchForBullets()

func randomLocation(maxX, minX, maxY, minY):
	var randomX = randi_range(minX, maxX)
	var randomY = randi_range(minY, maxY)
	
	return Vector2(randomX, randomY)

func randomRotation(delta):
	#var angle = location.angle()
	#var rotation = global_rotation
	#rotation per frame
	#var angle_delta = rotation_speed * delta
	#angle = lerp_angle(rotation, angle, rotation_weight)
	#limit per frame, constant rotation speed
	#angle = clamp(angle, rotation - angle_delta, rotation + angle_delta)
	#global_rotation = angle
	#if rotation == rotation_direction:
	#	var rotation_direction = randi_range(-360, 360)
	#rotation += rotation_direction * rotation_speed * delta
	look_at(location)

func _on_timer_timeout():
	spawn_bullet()
	timer.start()

func spawn_bullet():
	var bullet = loadBullet.instantiate()
	bullet.position = gun_pos.global_position
	bullet.look_at(location)
	#sets unique id for bullet
	#bullet.bullet_id = bullet_id
	#increases next bullet_id by 1
	bullet_id += 1
	get_window().call_deferred("add_child", bullet)

func searchForBullets():
	if get_tree().root.get_node("bullet") == null:
		spawn_bullet()
		timer.start()

func take_damage(dmg):
	health -= dmg
	if health < 0:
		print("joakim dead")
	health_bar.value = health

func _on_start_search_for_bullets_timer_timeout():
	start_search_for_bullets = true;

func _on_hit_box_body_entered(body):
	print("Player:" + str(body) + " entered enemy space!")
	if body.is_in_group("enemy_bullet"):
		body.self_destruct()
		take_damage(10)
