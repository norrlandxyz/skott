extends CharacterBody2D


@export var speed = 80
@export var rotation_speed = 1.5

const rotation_speed_amplifier = 1.002
const speed_amplifier= 1.002

var rotation_direction = 0

@onready var timer = $Timer

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	timer.start()

func _input(event):
	#self_destruct is equal to space key
	if event.is_action_pressed("self_destruct"):
		self_destruct()

#destroys current bullet
func self_destruct():
	queue_free()

#function process input
func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	velocity = transform.y * speed
	speed = speed * speed_amplifier
	rotation_speed = rotation_speed * rotation_speed_amplifier
	move_and_slide()


func _on_timer_timeout():
	self_destruct()
