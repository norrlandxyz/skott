extends CharacterBody2D

@export var speed = 80
@export var rotation_speed = 1.5

const rotation_speed_amplifier = 1.002
const speed_amplifier= 1.002

var rotation_direction = 0

var switch = 0

var destroy_self = false
var destroy_called = false

#const bullet_id = null

var is_controlling = false

var about_to_explode = false

@onready var initial_timer = $InitialTimer
@onready var final_timer = $FinalTimer

@onready var animated_sprite_2d = $AnimatedSprite2D

var loadExplosion = preload("res://bullet_test/explosion/explosion.tscn")
@onready var explosion_pos = $explosion_pos

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	initial_timer.start()
	var control = get_tree().get_nodes_in_group("control")[0]
	#control.on.connect(switchbullet)

func _input(event):
	#self_destruct is equal to space key
	if event.is_action_pressed("self_destruct"):
		pass

#destroys current bullet
func self_destruct():
	var explosion = loadExplosion.instantiate()
	explosion.global_position = explosion_pos.global_position
	#explosion.look_at(joakim.global_position)
	get_window().call_deferred("add_child", explosion)
	queue_free()

#function process input
func get_input():
	if is_controlling:
		#var bullets = get_tree().get_nodes_in_group("bullet")
		
		#if bullets.size() < 2:
		#	switch = 1
		
		#if switch == 1:
		rotation_direction = Input.get_axis("ui_left", "ui_right")
	else: 
		rotation_direction = 0
	
func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	velocity = transform.x * speed
	speed = speed * speed_amplifier
	rotation_speed = rotation_speed * rotation_speed_amplifier
	move_and_slide()
	
#func switchbullet(bullet):
	#var bullets = get_tree().get_nodes_in_group("bullet")
	
	#if bullets[bullet] == self:
	#	if switch == 0:
	#		switch = 1
	#else:
	#	switch = 0

func _on_initial_timer_timeout():
	#self_destruct()
	about_to_explode = true
	if !is_controlling:
		animated_sprite_2d.play("about_to_explode")
	else:
		animated_sprite_2d.play("about_to_explode_and_selected")
	final_timer.start()

func start_controlls():
	is_controlling = true
	if !about_to_explode:
		animated_sprite_2d.play("selected")
	else:
		animated_sprite_2d.play("about_to_explode_and_selected")

func stop_controlls():
	is_controlling = false
	if !about_to_explode:
		animated_sprite_2d.play("default")
	else:
		animated_sprite_2d.play("about_to_explode")

func _on_final_timer_timeout():
	self_destruct()

func _on_bullet_finder_body_entered(body):
	print("bullet:" + str(body))
	if body.is_in_group("enemy_bullet") or body.is_in_group("big_enemy_bullet"):
		body.queue_free()
		self_destruct()
	if !body.is_in_group("bullet") && !body.is_in_group("player") && !body.is_in_group("enemy"):
		self_destruct()
