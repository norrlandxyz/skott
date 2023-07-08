extends CharacterBody2D

const SPEED = 100.0
var location = randomLocation(1000, 0, 600, 0)

var rotation_weight = 1
var rotation_speed = PI
@export var rotation_direction = 0

@onready var timer = $Timer
var loadBullet = preload("res://bullet_test/bullet/bullet.tscn")

@onready var gun_pos = $GunPos


func _ready():
	#spawn_bullet()
	timer.start()


func _physics_process(delta):
	#rotation
	randomRotation(delta)
	
	#walk around
	print(global_position.distance_to(location))
	print(location)
	var velocity = (location - global_position).normalized() * SPEED
	move_and_collide(velocity * delta)
	if global_position.distance_to(location) < 200:
		location = randomLocation(1000, 0, 600, 0)

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
	bullet.rotation = self.global_rotation - 90
	get_window().call_deferred("add_child", bullet)
