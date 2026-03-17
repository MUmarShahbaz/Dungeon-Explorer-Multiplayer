extends Character
class_name Player

signal cam(direction : Vector2)

func _ready() -> void:
	add_to_group("players")
	var myCAM = CAM.new()
	myCAM.target = self
	add_child.call_deferred(myCAM)
	cam.connect(Callable(myCAM, "set_target_offset"))
	var myEars = AudioListener2D.new()
	add_child.call_deferred(myEars)
	myEars.make_current()
	super._ready()
	remove_from_group("characters")

var disable_controls := false

func _physics_process(delta: float) -> void:
	if HP_Current <= 0: return
	super._physics_process(delta)
	if not disable_controls: control()

func control():
	movement()
	if Input.is_action_just_pressed("primary"): primary()
	if Input.is_action_just_pressed("secondary"): secondary()
	var cam_dir = Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down").normalized()
	emit_signal("cam", cam_dir)
	if Input.is_action_just_pressed("heal"): heal()
	if Input.is_action_just_pressed("boost"): boost()

func movement():
	if pause_movement(): return
	if Input.is_action_just_pressed("dodge"): dodge()
	move(Input.get_axis("left", "right"), Input.is_action_pressed("sprint"))
	if Input.is_action_just_pressed("jump"): jump()
