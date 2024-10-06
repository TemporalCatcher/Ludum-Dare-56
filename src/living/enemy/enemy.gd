extends Living
class_name  Enemy

var ai := EnemyyAI.new()

func _physics_process(delta: float) -> void:
	
	pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	health -= 1
	if health == 0:
		queue_free()
		
