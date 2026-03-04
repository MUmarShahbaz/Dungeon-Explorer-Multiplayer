extends Node2D
class_name PlayerSpawner

var player_selector : PackedScene = preload("res://scenes/player_spawner/player_selector.tscn")
var hud : PackedScene = preload("res://scenes/player_spawner/hud.tscn")

signal player_spawned(player : Player)

var player_id : int

@rpc("authority", "call_remote", "reliable")
func display_player_selector():
	var new_selector = player_selector.instantiate()
	(new_selector.continue_btn as Button).pressed.connect(func ():
		if new_selector.selected:
			spawn.rpc(new_selector.selected, multiplayer.get_unique_id())
			new_selector.queue_free()
	)
	get_tree().get_current_scene().add_child.call_deferred(new_selector)

@rpc("any_peer", "call_local", "reliable")
func spawn(selected, id):
	if !multiplayer.is_server(): return
	var new_player = load(selected[&"scene"]).instantiate()
	new_player.name = str(id)
	(new_player as Player).entity_died.connect(spawn.rpc.bind(selected, id))
	get_tree().current_scene.add_child.call_deferred(new_player)
	new_player.global_position = global_position
	player_spawned.emit(new_player)
	await new_player.ready
	if id != 1: create_hud.rpc_id(id, id, selected[&"image"])
	else: create_hud(id, selected[&"image"])

@rpc("reliable")
func create_hud(id, image):
	var new_hud = hud.instantiate()
	new_hud.multiplayer_id = id
	new_hud.avatar = AtlasTexture.new()
	new_hud.avatar.atlas = load(image)
	new_hud.avatar.region.position = Vector2(16, 8)
	new_hud.avatar.region.size = Vector2(32, 32)
	add_child.call_deferred(new_hud)
