extends AttackInfo
## A resource that can be used with the [ProjectileLauncher] class to give the character the ability to launch [Projectile]
class_name ProjectileAttack

## Frame number to launch the projectile
@export var Launch_Frame : int
## The [Projectile]
@export var Projectile_Scene : PackedScene
## Offset at which the projectile is spawned
@export var Spawn_Offset : Vector2
## The force to launch the projectile with
@export var Force : int
