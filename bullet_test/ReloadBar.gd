extends ProgressBar
@onready var joakim = $"../Joakim"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):  
	self.global_position = joakim.global_position + Vector2(-50, -50)
