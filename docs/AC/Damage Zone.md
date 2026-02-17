```gdscript
extends Area2D
class_name DamageZone
```

Uses a `CollisionShape2D` or `CollisionPolygon2D` to define an area where any [Entity](ECS/Entity) present will sustain damage when activated.

## Notes

- It uses a `RayCast2D` to check if there are any obstructions in between to make sure any [Entity](ECS/Entity) that is behind an obstruction is not hit.
- Which [Entity](ECS/Entity) can get damaged within this region is determined at load based upon the class of the parent. If it is a [Player](ECS/Player) then it will hit only [Enemy](ECS/Enemy) and vice versa.
- The obstruction check depends entirely on the `RayCast2D` and it's collision mask values. By default it will consider only the Map and [Shield](AC/Shield) colliders as an obstruction.

## Configuration

- Once added to an [Entity](ECS/Entity), you only need to define the region where damage is dealt.
- To avoid any issues, make sure that there is only one child of this node and it's the one which is defining the effective region.
- The effective region must be defined by using only one of the following:
	- `CollisionShape2D`
	- `CollisionRegion2D`
- You should not try to modify any of the settings in the inspector unless necessary.
- In the **Individual Class** (described in the [ECS](Entity%20Component%20System.md)), overwrite the `flip()` function of the [Entity](ECS/Entity) to flip this node as well

## Usage

```gdscript
damage_all(amount)           # applies specific damage to all detected entities
flip()                       # flips the region horizontally
```

Damage can only be manually applied via the `damage_all(amount)` function. Any automation must be done via other nodes (for example: [Melee Controller](AC/Melee%20Controller))