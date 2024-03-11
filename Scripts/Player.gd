extends CharacterBody3D


const SPEED := 200
const FRICTION := 15
const JUMP_VELOCITY := 4
const MOUSE_SENSITIVITY := 0.00175

var mouse_input := Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Look around
	self.rotate_y(mouse_input.x)
	$Camera3D.rotate_x(mouse_input.y)
	$Camera3D.rotation.x = clamp(
		$Camera3D.rotation.x,
		deg_to_rad(-90),
		deg_to_rad(90)
	)
	mouse_input = Vector2.ZERO

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.z = direction.z * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		velocity.z = move_toward(velocity.z, 0, FRICTION * delta)

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if GameState.is_mouse_in_game_mode():
			mouse_input.x = -event.relative.x * MOUSE_SENSITIVITY
			mouse_input.y = -event.relative.y * MOUSE_SENSITIVITY
