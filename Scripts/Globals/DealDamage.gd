extends Node

func deal_damage(damage: int, hit: Enemy):
	hit.takeDamage(damage)
	
func damage_friend(damage: int, hit):
	hit.take_damage(damage)
