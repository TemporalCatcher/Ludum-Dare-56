extends Living
class_name Plush

var ai := FriendlyAI.new(self)

var attack_range := 20
var chase_range := 100
var idle_range := 23
var areas : Array[Area2D] = [] 

func _ready() -> void:
	play(&"idle_down")


func _physics_process(delta: float) -> void:
	ai.update(delta)
	if not areas.is_empty():
		call_deferred("slide")


func slide() -> void:
	var area : Area2D = $Occupy
	var body : CollisionShape2D = area.find_child("Body")
	var radius : float = body.shape.radius
	var accum := Vector2.ZERO
	for a in areas:
		var b : CollisionShape2D = a.find_child("body")
		var r : float = body.shape.radius
		var vect := a.global_position - area.global_position
		var dist1 := sqrt(vect.x * vect.x + vect.y * vect.y)
		var dist2 := radius + r
		accum += vect.normalized() * (dist2 - dist1) / 2
	position -= accum


func follow_move(delta : float) -> void:
	var olivia := World.get_olivia()
	var vect := (olivia.position - position).normalized()
	var distance := position.distance_to(olivia.position)
	if distance < idle_range:
		idle_direction()
		ai.state = ai.states[ai.PATROL]
		return
	position += vect * min(distance * 2, 50) * delta
	walk_direction(vect)


func attack() -> void:
	match facing:
		Vector2.RIGHT:
			play("attack_right")
		Vector2.DOWN:
			play("attack_down")
		Vector2.LEFT:
			play("attack_left")
		Vector2.UP:
			play("attack_up")


func will_give_chase() -> bool:
	var enemy := World.closest_enemy_to_plush(self)
	if not enemy.is_empty():
		if enemy["distance"] <= 100:
			return true
	return false


func _on_attack_finished() -> void:
	var enemy := World.closest_enemy_to_plush(self)
	if enemy.is_empty():
		ai.state = ai.states[ai.FOLLOW]
		return
	var dist := enemy["distance"] as float
	if dist > chase_range:
		return
	if dist < attack_range:
		attack()
		return
	ai.state = ai.states[ai.CHASE]


func _on_frame_changed() -> void:
	if frame < 4:
		return
	
	var coll : CollisionShape2D
	match facing:
		Vector2.RIGHT:
			coll = $Attack/Right
		Vector2.DOWN:
			coll = $Attack/Down
		Vector2.LEFT:
			coll = $Attack/Left
		Vector2.UP:
			coll = $Attack/Up
	coll.disabled = !coll.disabled


func _on_occupy_area_entered(area: Area2D) -> void:
	areas.push_back(area)


func _on_occupy_area_exited(area: Area2D) -> void:
	areas.erase(area)
