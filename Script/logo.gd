extends Sprite2D
var turnSpeed = 0.2

func turn():
	print("Loaded")
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += turnSpeed *delta
	#print("Canvas ", get_canvas_transform())
	print("Transform -->", transform.x)
	
	
