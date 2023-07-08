extends ProgressBar
@onready var enemy = $"../Enemy"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position = enemy.global_position + Vector2(-50, -50)
