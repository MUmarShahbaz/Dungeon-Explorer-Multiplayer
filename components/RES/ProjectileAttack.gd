extends Resource
## A resource that can be used with the [ProjectileLauncher] class to give the character the ability to launch [Projectile]
class_name ProjectileAttack

## Name of the Animation for launching the Projectile
@export var Animation_Name : String
## Frame number to spawn the projecile
@export var Load_Animation_Frame : int
## Frame number to launch the projectile
@export var Launch_Animation_Frame : int
## The [Projectile]
@export var Projectile_Scene : PackedScene
## Offset at which the projectile is spawned
@export var Spawn_Offset : Vector2
## The force to launch the projectile with
@export var Force : int
