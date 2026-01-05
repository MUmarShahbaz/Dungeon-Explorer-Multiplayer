extends TileMapLayer

var cells = {
	"breakable_floor" : Vector2i(),
	"spikes_in" : Vector2i(),
	"spikes_out" : Vector2i()
}

func _ready() -> void:
	for cell in get_used_cells():
		match get_cell_atlas_coords(cell):
			cells.breakable_floors:
				create_area(cell, Vector2i(24, 0), "break_floor")
			cells.spikes_in:
				create_area(cell, Vector2i(24, 48), "activate_spike")
			cells.spikes_out:
				create_area(cell, Vector2i(24, 48), "activate_spike")

func create_area(cell, local_position, handler):
	var shape    : RectangleShape2D = RectangleShape2D.new()
	var collider : CollisionShape2D = CollisionShape2D.new()
	var area     : Area2D           = Area2D.new()
	
	shape.size = Vector2(48, 48)
	collider.shape = shape
	area.add_child(collider)
	area.global_position = map_to_local(cell) + local_position
	area.body_entered.connect(Callable(self, handler).bind(area, cell))
	get_tree().get_current_scene().add_child(area)

func break_floor(body, floor_piece : Area2D, cell):
	if body is not Player: return
	await get_tree().create_timer(1.5).timeout
	floor_piece.queue_free()
	set_cell(cell, -1)

func activate_spike(body, spike_piece : Area2D, cell):
	if body is not Player: return
	if get_cell_atlas_coords(cell) == cells.spikes_in:
		await get_tree().create_timer(1.5).timeout
		set_cell(cell, 1, cells.spikes_out, 0)
	for this_body in spike_piece.get_overlapping_bodies():
		if this_body is Player: (this_body as Player).die()
	await get_tree().create_timer(1.5).timeout
	set_cell(cell, 1, cells.spikes_in, 0)
