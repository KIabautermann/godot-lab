extends Timer

var counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += delta
	pass


func _on_timeout():
	print_debug(counter)
	counter = 0
	pass # Replace with function body.
