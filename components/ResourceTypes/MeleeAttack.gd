extends Resource
## A resource that can be used with the [MeleeController] class to give the character the ability to use melee attacks
class_name MeleeAttack

## Name of the Animation for this attack
@export var Animation_Name : String
## Frame number to activate the hitbox
@export var Animation_Frame : int
## The hitbox of the attack
@export var Damage_Zone : NodePath
## The Damage done by this attack
@export var Damage : float
