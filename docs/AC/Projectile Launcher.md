```gdscript
extends Node
class_name ProjectileLauncher
```

Detects the current animation and triggers both, spawn and launch, of a new [Projectile](MISC/Projectile) with an appropriate force as defined in the `Move_List` array.

## Notes

- The force at which a projectile is released corelates to it's speed and not it's damage.
- The `Move_List` variable is an array of [Projectile Attack](RES/Projectile%20Attack)s which binds a specific frame of a specific animation to spawning the new [Projectile](MISC/Projectile) and another to launching it.
- Each [Projectile Attack](RES/Projectile%20Attack) also contains the offset at which to spawn the [Projectile](MISC/Projectile) from the parent [Entity](ECS/Entity) which this automatically translates to the direction the parent entity is currently facing.

## Configuration

- Define the `Move_List` in the editor
	- For each [Projectile Attack](RES/Projectile%20Attack), go to your entity and manually calculate the offset from the center of the entity and assign it in the editor