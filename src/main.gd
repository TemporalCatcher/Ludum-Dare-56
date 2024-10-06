extends Node2D
class_name Main

signal move_controlled(vect : Vector2)


func _ready() -> void:
	var teddy : Plush = $Teddy


func _physics_process(delta: float) -> void:
	move_controlled.emit(control_direction() * delta)
	

func control_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
