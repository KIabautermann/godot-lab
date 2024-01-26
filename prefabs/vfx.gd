extends AnimatedSprite2D
@export var lifetime : float

# Called when the node enters the scene tree for the first time.
func _ready():
	play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifetime -= delta
	if lifetime <= 0 : queue_free()
