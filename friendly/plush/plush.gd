extends AnimatedSprite2D
class_name Plush

var leader : Olivia = null
var facing := Vector2.DOWN

func _ready() -> void:
	play(&"idle_down")

func _physics_process(delta: float) -> void:
	if leader == null:
		return
	var vect := (leader.position - position).normalized()
	var distance := position.distance_squared_to(leader.position)
	if distance < 400:
		idle_direction()
		return
	position += vect * min(distance / 4, 50) * delta
	walk_direction(vect)


func  walk_direction(vect : Vector2) -> void:
	var vect2 := vect.abs()
	if vect2.x >= vect2.y: # horizontal facing
		if vect.x < 0:
			facing = Vector2.LEFT
		else:
			facing = Vector2.RIGHT
	else:
		if vect.y < 0:
			facing = Vector2.UP
		else:
			facing = Vector2.DOWN
	
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
