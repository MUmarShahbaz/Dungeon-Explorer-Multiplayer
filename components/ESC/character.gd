extends Entity
class_name Character

@export_group("Items", "ITM")
@export var ITM_Healing_Potions : int = 3
@export var ITM_Booster_Potions : int = 5
var SP_Special_Points : float = 0

@export_group("Dialogue Images", "DIA")
@export var DIA_Aggression : Texture2D
@export var DIA_Calm : Texture2D
@export var DIA_Sadness : Texture2D
@export var DIA_Smile : Texture2D
@export var DIA_Special : Texture2D
@export var DIA_Talk : Texture2D

func _ready() -> void:
	add_to_group("characters")
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
	visibility_layer = 2

func _physics_process(delta: float) -> void:
	if HP_Current <= 0: return
	move_and_slide()
	super._physics_process(delta)

func dodge():
	if pause_movement(): return
	force_pause = true
	velocity = Vector2(MV_Run_Speed*facing*-1, MV_Jump/2)
	ANM_Animation_Tree.get("parameters/playback").start("jump")
	await get_tree().physics_frame
	while not is_on_floor():
		await get_tree().physics_frame
	force_pause = false

func move(delta, x_dir, run = false):
	if pause_movement(): return
	if x_dir != 0:
		if run:
			velocity.x = x_dir * MV_Run_Speed * delta * 60
			if is_on_floor(): ANM_Animation_Tree.get("parameters/playback").travel("run")
		else:
			velocity.x = x_dir * MV_Speed * delta * 50
			if is_on_floor(): ANM_Animation_Tree.get("parameters/playback").travel("walk")
	else: velocity.x = 0
	if x_dir * facing < 0 : flip()

func jump():
	if pause_movement() or not is_on_floor(): return
	velocity.y += MV_Jump
	ANM_Animation_Tree.get("parameters/playback").travel("jump")

func heal():
	ITM_Healing_Potions -= 1
	HP_Current += HP_Regeneration_Rate * 60

func boost():
	ITM_Booster_Potions -= 1
	SP_Special_Points += 60

func primary():
	pass

func secondary():
	pass
