extends Node
class_name Damager

@onready var parent = get_parent() as Entity
@export var Move_List : Array[AttackInfo]
var multiplier : float = 1
var attacking = null

func _process(_delta: float) -> void:
	if attacking:
		if parent.check_anim(attacking) == false:
			attacking = null
	else:
		for this_attack : AttackInfo in Move_List:
			if parent.check_frame(this_attack.Animation_Name, this_attack.Animation_Frame):
				attacking = this_attack.Animation_Name
				attack(this_attack)

func get_avg_damage():
	var sum_damages : float = 0
	for this_attack : AttackInfo in Move_List:
		sum_damages += this_attack.Damage
	return int(sum_damages / Move_List.size())

func attack(attack_info : AttackInfo):
	pass
