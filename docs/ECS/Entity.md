```gdscript
extends CharacterBody2D
class_name Entity
```

Abstract base class for **all living/moving/damageable 2D entities** in the project

This is the **common foundation** for:
- Player
- Enemies
- NPCs
- Bosses



## Notes

- `_physics_process(delta)` contains:  
  - HP/SP regeneration  
  - Gravity  Effect
  - Deceleration Effect
- **No movement/input/AI** is implemented on purpose
  - child classes must add it themselves:
    ```gdscript
	  func _physics_process(delta):
			if HP_Current <= 0: return
			super._physics_process(delta)
			# Additional code goes here
    ```
- `take_damage(amount)` is the appropriate way to **hurt** the Entity.  
- Death is automatically handled by `take_damage()` if HP falls below 0.
- `flip()` is used when you need to change the direction the character is facing.
  - child classes must add any additional flip-able components:
    ```gdscript
	func flip():
			super.flip()
			# Flip other components which need to be fliped
			# eg. MeleeController.flip()
    ```
- We can track the current direction using the `facing : int` variable.
  - `0` : Left
  - `1` : Right
- The `protect : bool` variable tells us whether this entity is protected by a shield or alternative means.

### Utility Methods

```gdscript
die()                         # appropriate way to kill the entity
flip()                        # flip the character horizontal
await_frame(anim, frame)      # wait until specific animation frame
check_anim(animation)         # is currently playing this animation?
check_frame(animation, frame) # is on this exact frame?
```


## Exposed Systems & Properties

### Stats

<table>
	<tr>
		<th colspan=2 align=center>Health (HP)</th>
	</tr>
	<tr>
		<th>HP_Health_Points</th>
		<td>Max HP of the Entity</td>
	</tr>
	<tr>
		<th>HP_Regeneration_Rate</th>
		<td>HP Regenerated per second</td>
	</tr>
	<tr>
		<th>HP_Current</th>
		<td>Current HP of the Entity</td>
	</tr>
	
	<tr>
		<th colspan=2 align=center>Stamina (SP)</th>
	</tr>
	<tr>
		<th>SP_Stamina_Points</th>
		<td>Max SP of the Entity</td>
	</tr>
	<tr>
		<th>SP_Regeneration_Rate</th>
		<td>SP Regenerated per second</td>
	</tr>
	<tr>
		<th>SP_Current</th>
		<td>Current SP of the Entity</td>
	</tr>
	<tr>
		<th colspan=2 align=center>Movement (MV))</th>
	</tr>
	<tr>
		<th>MV_Speed</th>
		<td>Walking speed of the Entity</td>
	</tr>
	<tr>
		<th>MV_Run_Speed</th>
		<td>Sprinting speed of the entity</td>
	</tr>
	<tr>
		<th>MV_Jump</th>
		<td>Upwards velocity gain on Jump</td>
	</tr>
</table>

### Animation & Audio

All animation & sound nodes that an entity may require are declared here:

**Animation nodes**  
- `ANM_Animated_Sprite`
- `ANM_Animation_Player`
- `ANM_Animation_Tree`

**Sound players**  
- `SFX_Walk`  
- `SFX_Run`  
- `SFX_Jump`  
- `SFX_Hurt`  
- `SFX_Die`  
- `SFX_Heal`  