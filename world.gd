extends Node2D

@export var earth_orbit_speed = 1.0
@export var moon_orbit_speed = 2.0
@export var earth_distance_from_sun = 200.0
@export var moon_distance_from_earth = 50.0
@export var point_lifetime = 60  # Time in frames for how long points should remain visible (assuming 60 FPS ~ 1 second)

# Arrays to hold the points
var earth_orbit_points = []
var moon_orbit_points = []
var earth_orbit_timers = []
var moon_orbit_timers = []

func gunesOrtasi(): # Click --> 
	var screen_center = get_viewport_rect().size / 2 # Find the center of the screen
	
	$Sun.position = screen_center # Move the Sun to the center of the screen
	$Sun.scale = Vector2(0.5, 0.5) # Scale the Sun down to 0.5
	print($Sun.position) # Show the position of the Sun

# This function runs when the game starts
func _ready():
	gunesOrtasi()
	$Sun/Earth.position = Vector2(earth_distance_from_sun, 0)
	$Sun/Earth/Moon.position = $Sun/Earth.position + Vector2(moon_distance_from_earth, 0).rotated($Sun/Earth.rotation)

	# Clear existing points in the Line2D nodes
	$Sun/Earth.get_node("EarthOrbit").clear_points()  
	$Sun/Earth/Moon.get_node("MoonOrbit").clear_points()  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Earth orbits around the Sun
	$Sun/Earth.rotation += earth_orbit_speed * delta
	$Sun/Earth.position = Vector2(earth_distance_from_sun, 0).rotated($Sun/Earth.rotation)
	
	# Add the Earth's current position to its orbit line
	var earth_position = $Sun/Earth.position
	$Sun/Earth.get_node("EarthOrbit").add_point(earth_position)
	earth_orbit_points.append(earth_position)
	earth_orbit_timers.append(0)  # Start a timer for this point

	# Moon orbits around the Earth
	$Sun/Earth/Moon.rotation += moon_orbit_speed * delta
	var moon_position = $Sun/Earth.position + Vector2(moon_distance_from_earth, 0).rotated($Sun/Earth.rotation + $Sun/Earth/Moon.rotation)
	$Sun/Earth/Moon.position = moon_position

	# Add the Moon's current position to its orbit line
	$Sun/Earth/Moon.get_node("MoonOrbit").add_point(moon_position)  
	moon_orbit_points.append(moon_position)  
	moon_orbit_timers.append(0)  # Start a timer for this point

	# Update timers and remove old points for both orbits

# Function to update timers and remove points older than point_lifetime
func update_and_remove_points(points, timers, line_node):
	# Check the size of timers to avoid index out of bounds
	var i = 0
	while i < timers.size():
		timers[i] += 1  # Increment the timer for each point
		if timers[i] > point_lifetime:  # Check if the point exceeds the lifetime
			# Remove the point and timer at index i
			points.remove_at(i)  
			timers.remove_at(i)  
			line_node.clear_points()  # Clear all points before re-adding the remaining ones
			for p in points:
				line_node.add_point(p)
		else:
			i += 1  # Only increment if no point was removed
