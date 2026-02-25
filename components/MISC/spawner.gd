extends Area2D
class_name Spawner

@onready var spawn_regions : Array[Node] = get_children()

@export var Mob_Scenes : Array[PackedScene]
@export var Spawn_Root : Node
@export_group("Continous")
@export var Rate: float = 0.5
@export_group("Once")
@export var Initial_Spawns : int = 10

func _ready():
	monitoring = false
	monitorable = false


var time_counter : float
var spawning : bool = false
func _physics_process(delta: float) -> void:
	if spawning:
		time_counter += delta
		if time_counter >= 1/Rate:
			time_counter = 0
			spawn()

func begin():
	if !multiplayer.is_server(): return
	for i in Initial_Spawns:
		spawn()
	spawning = true

func spawn():
	var this_region : CollisionShape2D = spawn_regions.pick_random()
	var extents : Vector2 = (this_region.shape as RectangleShape2D).extents
	var local_random_position : Vector2 = Vector2(randf_range(-extents.x, extents.x), randf_range(-extents.y, extents.y))
	var mob_to_spawn : PackedScene = Mob_Scenes.pick_random()
	var mob : Entity = mob_to_spawn.instantiate()
	mob.global_position = to_global(this_region.to_global(local_random_position))
	if Spawn_Root != null : Spawn_Root.add_child.call_deferred(mob, true)
	else : add_sibling(mob, true)
