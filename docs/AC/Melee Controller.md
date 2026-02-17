```gdscript
extends Node
class_name MeleeController
```

Detects the current animation playing and triggers an appropriate [Damage Zone](AC/Damage%20Zone) with the appropriate damage as defined in the `Move_List` array. 

## Notes

- Also acts as a bridge between all [Damage Zone](AC/Damage%20Zone)s and the parent [Entity](ECS/Entity) to make sure they are all flipped together using `flip()`
- The `Move_List` variable is an array of [Melee Attack](RES/Melee%20Attack)s which binds a specific frame of a specific animation to a [Damage Zone](AC/Damage%20Zone) and a value for damage sustained by any [Entity](ECS/Entity) inside that [Damage Zone](AC/Damage%20Zone)

## Configuration

- Define the `Move_List` in the editor
- In the **Individual Class** (described in the [ECS](Entity%20Component%20System.md)), overwrite the `flip()` function of the [Entity](ECS/Entity) to flip this node as well
	- Note that it will automatically flip all the associated [Damage Zone](AC/Damage%20Zone)s so they don't need to be defined explicitly