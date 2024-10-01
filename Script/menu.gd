extends Node2D



func _on_start_button_pressed():
	var error = get_tree().change_scene("res://Scenes/world.tscn")
	if error != OK:
		print("Failed to load scene. Error code: ", error)



func _on_exit_button_pressed():
	get_tree().quit()
