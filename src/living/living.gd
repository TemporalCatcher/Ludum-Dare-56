extends AnimatedSprite2D
class_name  Living

var facing := Vector2.DOWN
var max_hp := 4
var health := 4:
	get:
		return health
	set(value):
		health = clamp(value, 0, max_hp)

func  walk_direction(vect : Vector2) -> void:
	var vect2 := vect.abs()
	var face : Vector2
	if vect2.x >= vect2.y: # horizontal facing
		if vect.x < 0:
			face = Vector2.LEFT
		else:
			face = Vector2.RIGHT
	else:
		if vect.y < 0:
			face = Vector2.UP
		else:
			face = Vector2.DOWN
	if face == facing and animation.begins_with("walk"):
		return
	facing = face
	match  facing:
		Vector2.RIGHT:
			play(&"walk_right")
		Vector2.DOWN:
			play(&"walk_down")
		Vector2.LEFT:
			play(&"walk_left")
		Vector2.UP:
			play(&"walk_up")


func idle_direction() -> void:
	if animation.begins_with("idle"):
		return
	match  facing:
		Vector2.RIGHT:
			play(&"idle_right")
		Vector2.DOWN:
			play(&"idle_down")
		Vector2.LEFT:
			play(&"idle_left")
		Vector2.UP:
			play(&"idle_up")
