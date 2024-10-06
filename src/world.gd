extends Node

var main : Main
var olivia : Olivia

func _ready() -> void:
	main = get_tree().root.get_child(1)
	olivia = main.find_child("Olivia")
	
func get_enemies() -> Array[Enemy]:
	var list : Array[Enemy] = []
	for i in main.get_children():
		if i.is_in_group(&"enemies"):
			list.append(i)
	return list


func closest_enemy_to_plush(plush : Plush) -> Dictionary:
	var enemies := get_enemies()
	if enemies.is_empty():
		return {}
	enemies.sort_custom(func (a : Enemy, b : Enemy) -> bool: 
		var left := plush.position.distance_squared_to(a.position)
		var right := plush.position.distance_squared_to(b.position)
		return left <= right)
	var enemy := enemies[0]
	return {"distance": plush.position.distance_to(enemy.position), "enemy": enemy}


func get_olivia() -> Olivia:
	return olivia
