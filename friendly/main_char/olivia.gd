extends Sprite2D
class_name Olivia

var speed := 100

func _on_move_controlled(vect: Vector2) -> void:
	position += vect * speed
