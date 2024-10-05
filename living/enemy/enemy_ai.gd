extends StateMachine
class_name EnemyyAI

enum {
	PATROL,
	CHASE,
	ATTTACK
}


func _init() -> void:
	states.push_back(Patrol.new())
	states.push_back(Chase.new())
	states.push_back(Attack.new())
	state = states[PATROL]


class Patrol extends State:
	func update() -> void:
		pass


class Chase extends State:
	func update() -> void:
		pass


class Attack extends State:
	func update() -> void:
		pass
