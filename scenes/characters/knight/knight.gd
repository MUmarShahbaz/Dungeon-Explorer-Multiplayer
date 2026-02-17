extends Player
class_name Knight

@export var Primary_Move_Buffer : Buffer
@export var melee_controller : MeleeController
@export var shield : Shield

func _process(_delta: float) -> void:
	ANM_Animation_Tree.set("parameters/conditions/attack", Primary_Move_Buffer.buffer)

func primary():
	Primary_Move_Buffer.start()

func secondary():
	ANM_Animation_Tree.set("parameters/conditions/not_protect", false)
	ANM_Animation_Tree.set("parameters/conditions/protect", true)
	shield.activate()
	while Input.is_action_pressed("secondary"):
		await get_tree().physics_frame
	shield.deactivate()
	ANM_Animation_Tree.set("parameters/conditions/protect", false)
	ANM_Animation_Tree.set("parameters/conditions/not_protect", true)


func flip():
	super.flip()
	melee_controller.flip()
	shield.flip()
