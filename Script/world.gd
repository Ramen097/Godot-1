extends Node2D

@export var earth_orbit_speed = 1.0
@export var moon_orbit_speed = 2
@export var earth_distance_from_sun = 200.0
@export var moon_distance_from_earth = 50.0
@export var point_lifetime = 60  # Time in frames for how long points should remain visible (assuming 60 FPS ~ 1 second)


func gunesOrtasi(): # Click --> 
	var screen_center = get_viewport_rect().size / 2 # Find the center of the screen
	
	$Sun.position = screen_center # Move the Sun to the center of the screen
	$Sun.scale = Vector2(0.5, 0.5) # Scale the Sun down to 0.5
	print($Sun.position) # Show the position of the Sun

# This function runs when the game starts
func _ready():
	gunesOrtasi()
	$Sun/Earth.position = Vector2(earth_distance_from_sun, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Earth orbits around the Sun
	$Sun/Earth.rotation += earth_orbit_speed * delta
	$Sun/Earth.position = Vector2(earth_distance_from_sun, 0).rotated($Sun/Earth.rotation)
	
