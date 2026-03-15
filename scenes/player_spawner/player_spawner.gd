extends Node2D
class_name PlayerSpawner

var player_selector : PackedScene = preload("res://scenes/player_spawner/player_selector.tscn")
var hud : PackedScene = preload("res://scenes/player_spawner/hud.tscn")

signal player_spawned(player : Player, death_count : int)
var death_count := 0

func display_player_selector():
	var new_selector = player_selector.instantiate()
	(new_selector.continue_btn as Button).pressed.connect(func ():
		if new_selector.selected:
			spawn(new_selector.selected, true)
			new_selector.queue_free()
	)
	get_tree().get_current_scene().add_child.call_deferred(new_selector)

func spawn(selected, first_spawn = false):
	if not first_spawn: death_count += 1
	var new_player = load(selected[&"scene"]).instantiate()
	(new_player as Player).entity_died.connect(spawn.bind(selected))
	(new_player as Player).global_position = self.global_position
	get_tree().current_scene.add_child.call_deferred(new_player)
	var new_hud = hud.instantiate()
	new_hud.player = new_player
	new_hud.avatar = AtlasTexture.new()
	new_hud.avatar.atlas = load(selected[&"image"])
	new_hud.avatar.region.position = Vector2(16, 8)
	new_hud.avatar.region.size = Vector2(32, 32)
	add_child.call_deferred(new_hud)
	player_spawned.emit(new_player, death_count)
