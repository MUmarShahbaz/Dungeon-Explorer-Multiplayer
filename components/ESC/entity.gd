extends CharacterBody2D
## Base class of all entities.
##
## This class includes the assignment of the following properties:[br]
## > Health and Stamina[br]
## > Movement[br]
## > Attack[br]
## > Animation & SFX[br]
class_name Entity

#region Properties
@export_group("Health", "HP")
## Max HP
@export var HP_Health_Points : float = 100
## HP gained per second
@export var HP_Regeneration_Rate : float = 1
## Current HP
@onready var HP_Current = HP_Health_Points

@export_group("Stamina", "SP")
## Max SP
@export var SP_Stamina_Points : float = 100
## SP gained per second
@export var SP_Regeneration_Rate : float = 1
## Current SP
@onready var SP_Current = SP_Stamina_Points

@export_group("Movement", "MV")
## Walking Speed
@export var MV_Speed : float = 100
## Running Speed
@export var MV_Run_Speed : float = 300
## Jump Force
@export var MV_Jump : float = -300

@export_group("Animation", "ANM")
## AnimatiedSprite2D
@export var ANM_Animated_Sprite : AnimatedSprite2D
## AnimationPlayer
@export var ANM_Animation_Player : AnimationPlayer
## AnimationTree
@export var ANM_Animation_Tree : AnimationTree

@export_group("Sound Effects", "SFX")
## Walking SFX
@export var SFX_Walk : AudioStreamPlayer2D
## Running SFX
@export var SFX_Run : AudioStreamPlayer2D
## Jumping SFX
@export var SFX_Jump : AudioStreamPlayer2D
## Getting hurt SFX
@export var SFX_Hurt : AudioStreamPlayer2D
## Dying SFX
@export var SFX_Die : AudioStreamPlayer2D
## Healing SFX
@export var SFX_Heal : AudioStreamPlayer2D
#endregion

## The Direction the entity is facing. [code]0[/code] is Left, [code]1[/code] is Right
var facing : int = 1

func _physics_process(delta: float) -> void:
	# Gravity effect on all entities
	if not is_on_floor(): velocity += get_gravity() * delta
	
	# HP and SP regeneration
	if HP_Health_Points > HP_Current : HP_Current += HP_Regeneration_Rate * delta
	else: HP_Current = HP_Health_Points
	if SP_Stamina_Points > SP_Current : SP_Current += SP_Regeneration_Rate * delta
	else: SP_Current = SP_Stamina_Points
	
	# Deceleration Effect
	if velocity.x != 0: velocity.x = move_toward(velocity.x, 0, delta*10)

## Changes the direction the character is facing. Should be overwritten for more additions.
func flip() -> void:
	facing *= -1
	ANM_Animated_Sprite.flip_h = !ANM_Animated_Sprite.flip_h

## Reduces HP of the entity when it gets hurt and dies when HP falls below 0
func take_damage(amount : float) -> void:
	HP_Current -= amount
	if HP_Current <= 0:
		velocity = Vector2.ZERO
		ANM_Animation_Tree.get("parameters/playback").travel("die")
		ANM_Animation_Tree.advance(0)
		await await_frame("die", ANM_Animated_Sprite.sprite_frames.get_frame_count("die") - 1)
		queue_free()
		return
	else:
		velocity.x = 0
		ANM_Animation_Tree.get("parameters/playback").travel("hurt")
		ANM_Animation_Tree.advance(0)

## Insta-kill the entity
func die() -> void:
	take_damage(HP_Current)

## Checks the current animation playing
func check_anim(animation : String) -> bool:
	return ANM_Animated_Sprite.animation == animation

## Checks the current frame of a specific animation playing
func check_frame(animation : String, frame : int) -> bool:
	return ANM_Animated_Sprite.animation == animation and ANM_Animated_Sprite.frame == frame

## Waits for a specific frame of a specific animation to play
func await_frame(animation: String, frame : int) -> void:
	while !check_frame(animation, frame):
		await get_tree().physics_frame
	return
