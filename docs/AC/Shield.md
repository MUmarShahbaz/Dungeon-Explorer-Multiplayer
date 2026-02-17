```gdscript
extends StaticBody2D
class_name Shield
```

Defines a region that can essentially become an invisible wall at will.

## Notes

- When between the attacker and defender, it can block the following nodes:
	- [Damage Zone](AC/Damage%20Zone)
	- [Projectile](MISC/Projectile)
- It is simply a `CollisionShape2D` or `CollisionPolygon2D` which can be enabled/disabled at will.