These are components which are mostly autonomous and require between minimal to no setup at all. You can simply add them to an [Entity](ECS/Entity) and it will give it the specific ability of that node.

Here's a list of all Ability Components along with a one line description of what they do:

- [Damage Zone](AC/Damage%20Zone)
	- Creates a region where an [Entity](ECS/Entity) can deal damage easily.
- [Melee Controler](AC/Melee%20Controller)
	- Uses animations to automatically sync and trigger [Damage Zone](AC/Damage%20Zone)s in order to simulate a melee attack
- [Projectile Launcher](AC/Projectile%20Launcher)
	- Uses animations to automatically sync and shoot [Projectile](MISC/Projectile)s
- [Shield](AC/Shield)
	- Creates a solid region using a `StaticBody2D` which can be activated/deactivated at command.