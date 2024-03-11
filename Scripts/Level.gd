extends Node3D


func _ready() -> void:
	GameState.change_mouse_mode("GAME")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		GameState.change_mouse_mode()
