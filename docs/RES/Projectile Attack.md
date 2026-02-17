```gdscript
extends Resource
class_name ProjectileAttack
```

This custom resource groups information required by a [Projectile Launcher](AC/Projectile%20Launcher) to give an [Entity](ECS/Entity) the ability to shoot a [Projectile](MISC/Projectile).

## Properties
| Name | Description |
|:-:|:-|
| `Animation_Name` | Name of the Animation for this attack |
| `Load_Animation_Frame` | Frame number to spawn the [Projectile](MISC/Projectile) |
| `Launch_Animation_Frame` | Frame number to launch the [Projectile](MISC/Projectile) |
| `Projectile_Scene` | The appropriate [Projectile](MISC/Projectile) scene to spawn and launch |
| `Force` | The force with which to launch the [Projectile](MISC/Projectile) |
