extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#Start animation
	self.play("default")


func _on_animation_finished():
	#When animation is ended, KILL YOURSELF
	queue_free()
