extends Living
class_name Olivia

var speed := 100

func _on_move_controlled(vect: Vector2) -> void:
	if vect == Vector2.ZERO:
		idle_direction()
		return
	position += vect * speed
	walk_direction(vect)
