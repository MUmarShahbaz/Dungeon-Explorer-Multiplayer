```gdscript
extends RigidBody2D
class_name Projectile
```

A shoot-able element that causes damage on impact. Can be shot using a [Projectile Launcher](AC/Projectile%20Launcher).

## Notes

- Which [Entity](ECS/Entity) can get damaged within this region is determined at load based upon the class of the launcher. If it is a [Player](ECS/Player) then it will hit only [Enemy](ECS/Enemy) and vice versa.
- It will hit the Map and all [Shield](AC/Shield) nodes and destroy itself.
- It checks it's linear speed every `5s` and if it's less than `2px/s` then it will destroy itself to avoid clogging memory.
- It will only hit one object, be it the Map, [Shield](AC/Shield) or an [Entity](ECS/Entity)