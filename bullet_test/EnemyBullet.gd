extends CharacterBody2D

var joakim = null

@export var speed = 50
@export var rotation_speed = 1.5

const rotation_speed_amplifier = 1.002
const speed_amplifier= 1.002

var rotation_direction = 0

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
