extends CharacterBody2D

var joakim = null

@export var speed = 70
@export var rotation_speed = 1.5

const rotation_speed_amplifier = 1.002
const speed_amplifier= 1.002

var rotation_direction = 0

var loadExplosion = preload("res://bullet_test/explosion/explosion.tscn")
@onready var explosion_pos = $explosion_pos

#@onready var timer = $Timer


# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	joakim = get_tree().get_first_node_in_group("player")
	#timer.start()

func _physics_process(delta):
	var velocity = (joakim.global_position - global_position).normalized() * speed
	move_and_collide(velocity * delta)
	look_at(joakim.global_position)

func self_destruct():
	var explosion = loadExplosion.instantiate()
	explosion.global_position = explosion_pos.global_position
	#explosion.look_at(joakim.global_position)
	get_window().call_deferred("add_child", explosion)
	queue_free()

func _on_collisiondetector_body_entered(body):
	if !body.is_in_group("enemy") && !body.is_in_group("big_enemy_bullet") && !body.is_in_group("player"):
		self_destruct()
