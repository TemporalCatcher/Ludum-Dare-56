extends StateMachine
class_name FriendlyAI

signal moved
signal idled

enum {
	IDLE,
	FOLLOW,
	PATROL,
	CHASE,
	ATTTACK
}

var plush : Plush


func _init(p : Plush) -> void:
	states.push_back(Idle.new())
	states.push_back(Follow.new())
	states.push_back(Patrol.new())
	states.push_back(Chase.new())
	states.push_back(Attack.new())
	state = states[IDLE]
	plush = p
	for s : AIState in states:
		s.to_state.connect(_on_state_transition)
		s.to_state_special.connect(_on_state_transition)
		s.plush = p


func _on_state_transition(new_state : int, dict := {}):
	state = states[new_state]


func update(delta : float) -> void:
	state.update(delta)


class AIState extends State:
	var plush : Plush


class Idle extends AIState:
	func update(_delta : float) -> void:
		if plush.position.distance_to(World.get_olivia().position) <= 40:
			to_state.emit(FOLLOW)


class Follow extends AIState:
	func update(delta : float) -> void:
		if plush.will_give_chase():
			to_state.emit(CHASE)
			return
		plush.follow_move(delta)


class Patrol extends AIState:
	func update(delta : float) -> void:
		if plush.will_give_chase():
			to_state.emit(CHASE)
			return
		var distance := plush.position.distance_squared_to(World.get_olivia().position)
		if distance >= plush.idle_range:
			to_state.emit(FOLLOW)


class Chase extends AIState:
	var target : Enemy
	
	func update(delta : float) -> void:
		var enemy := World.closest_enemy_to_plush(plush)
		if enemy.is_empty():
			to_state.emit(FOLLOW)
			return
		target = enemy["enemy"]
		var vect := (target.position - plush.position).normalized()
		var distance := enemy["distance"] as float
		if distance < 10:
			plush.idle_direction()
			to_state.emit(ATTTACK)
			return
		plush.position += vect * 50 * delta
		plush.walk_direction(vect)


class Attack extends AIState:
	func enter() -> void:
		plush.attack()
	
	func update(_delta : float) -> void:
		
		pass
