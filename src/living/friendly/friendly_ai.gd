extends StateMachine
class_name FriendlyAI

enum {
	IDLE,
	FOLLOW,
	PATROL,
	CHASE,
	ATTTACK
}


func _init() -> void:
	states.push_back(Idle.new())
	states.push_back(Follow.new())
	states.push_back(Patrol.new())
	states.push_back(Patrol.new())
	states.push_back(Chase.new())
	states.push_back(Attack.new())
	state = states[PATROL]


class Idle extends State:
	func update() -> void:
		pass
	

class Follow extends State:
	func update() -> void:
		pass
	

class Patrol extends State:
	func update() -> void:
		pass


class Chase extends State:
	func update() -> void:
		pass


class Attack extends State:
	func update() -> void:
		pass
