class_name GameState extends Node


static func is_mouse_in_game_mode() -> bool:
	return Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED;


static func change_mouse_mode(target_mode := &"TOGGLE") -> void:
	print("Changing mouse mode to ", target_mode)
	
	match target_mode:
		&"TOGGLE":
			if is_mouse_in_game_mode():
				change_mouse_mode(&"OS")
			else:
				change_mouse_mode(&"GAME")
		
		&"OS":
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		&"GAME":
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		_:
			assert(false, "Invalid mouse mode requested!")
