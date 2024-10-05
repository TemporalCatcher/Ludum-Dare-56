extends Living
class_name Plush

var leader : Olivia = null
var ai := FriendlyAI.new()

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
