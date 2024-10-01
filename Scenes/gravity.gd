extends RigidBody2D

# Declare a variable to hold the reference to the Sun Node2D
var sun = get_parent().get_node("Sun/SunSprite")

# Define gravity constant
const G = 100
func _ready():
	if sun ==null:
		print("Sun Not FOund")
	else:
		print("sun Pos not found")
func _physics_process(_delta):
	# Get the vector from Earth to Sun
	var sun_position = sun.position
	var direction = sun_position - position
	var distance = direction.length()

	if distance == 0:
		return  # Prevent division by zero if the Earth is on top of the Sun

	# Normalize the direction and calculate gravitational force
	direction = direction.normalized()

	# Apply gravity force (simplified)
	var force = direction * G / (distance * distance)

	# Apply the force to the Earth (central impulse based on force calculated)
	apply_central_impulse(force)
