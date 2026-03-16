extends Character
class_name Player

signal cam(direction : Vector2)

func _ready() -> void:
	super._ready()
	remove_from_group("characters")
	add_to_group("players")
	var myCAM = CAM.new()
	myCAM.target = self
	add_child.call_deferred(myCAM)
	cam.connect(Callable(myCAM, "set_target_offset"))
	var myEars = AudioListener2D.new()
	add_child.call_deferred(myEars)
	myEars.make_current()

var disable_controls := false

func _physics_process(delta: float) -> void:
	if HP_Current <= 0: return
	super._physics_process(delta)
	if not disable_controls: control(delta)

func control(delta : float):
	attack()
	movement(delta)
	camera()
	special()

func camera():
	var cam_dir = Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down").normalized()
	emit_signal("cam", cam_dir)

func attack():
	if Input.is_action_just_pressed("primary"):
		primary()
	if Input.is_action_just_pressed("secondary"):
		secondary()

func special():
	if Input.is_action_just_pressed("heal") and ITM_Healing_Potions > 0:
		ITM_Healing_Potions -= 1
		HP_Current += HP_Regeneration_Rate * 60
	if Input.is_action_just_pressed("boost") and ITM_Booster_Potions > 0:
		ITM_Booster_Potions -= 1
		SP_Special_Points += 60

func movement(delta : float):
	if pause_movement(): return
	if Input.is_action_just_pressed("dodge"):
		force_pause = true
		velocity = Vector2(MV_Run_Speed*facing*-1, MV_Jump/2)
		ANM_Animation_Tree.get("parameters/playback").start("jump")
		await get_tree().physics_frame
		while not is_on_floor():
			await get_tree().physics_frame
		force_pause = false
	var x_dir : float = Input.get_axis("left", "right")
	if x_dir != 0:
		if Input.is_action_pressed("sprint"):
			velocity.x = x_dir * MV_Run_Speed * delta * 60
			if is_on_floor(): ANM_Animation_Tree.get("parameters/playback").travel("run")
		else:
			velocity.x = x_dir * MV_Speed * delta * 50
			if is_on_floor(): ANM_Animation_Tree.get("parameters/playback").travel("walk")
	else: velocity.x = 0
	if x_dir * facing < 0 : flip()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += MV_Jump
		ANM_Animation_Tree.get("parameters/playback").travel("jump")

# Functions to be rewritten in Lowest Child
func primary():
	pass
func secondary():
	pass
