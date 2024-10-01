extends Node2D  # Extend Node2D since this is the Sun node

# Speed of rotation (in radians per second)
var rotation_speed = 1.0
# Reference to the Earth node
@onready var earth = get_node("Node2D(EarthOrbit)")  # Adjusted path to the Earth node

# Orbit radius (distance from the Sun to Earth)
var orbit_radius = 100.0

func _ready():
	# Check if the Earth node is found
	if earth == null:
		print("Earth node not found!")
		return  # Exit if Earth node is not found

	# Set the initial position of the Earth
	earth.position = Vector2(orbit_radius, 0)  # Start at the right side of the Sun

func _process(delta):
	# Rotate the Earth's position around the Sun
	var angle = rotation_speed * delta  # Calculate the angle to rotate

	# Update Earth's position in a circular path around the Sun
	var current_position = earth.position  # Get the current position of the Earth
	current_position.x = cos(angle) * orbit_radius
	current_position.y = sin(angle) * orbit_radius

	earth.position = current_position  # Apply the new position to the Earth
