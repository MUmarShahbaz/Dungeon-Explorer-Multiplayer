```gdscript
extends Resource
class_name MeleeAttack
```

This custom resource groups information required by a [Melee Controller](AC/Melee%20Controller) about each individual Melee attack an [Entity](ECS/Entity) can make.

## Properties
| Name | Description |
|:-:|:-|
| `Animation_Name` | Name of the Animation for this attack |
| `Animation_Frame` | Frame number to activate the [Damage Zone](AC/Damage%20Zone) |
| `Damage_Zone` | The appropriate [Damage Zone](AC/Damage%20Zone) to activate |
| `Damage` | The damage inflicted by this attack |
