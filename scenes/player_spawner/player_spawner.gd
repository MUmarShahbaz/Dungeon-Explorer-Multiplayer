extends Node2D
class_name PlayerSpawner

var player_selector : PackedScene = preload("res://scenes/player_spawner/player_selector.tscn")
var hud : PackedScene = preload("res://scenes/player_spawner/hud.tscn")

signal entity_spawned

var player_id : int
var selected : Dictionary

func display_player_selector():
	var new_selector = player_selector.instantiate()
	(new_selector.continue_btn as Button).pressed.connect(func ():
		if new_selector.selected:
			selected = new_selector.selected
			new_selector.queue_free()
			spawn()
	)
	get_tree().get_current_scene().add_child.call_deferred(new_selector)

func spawn():
	var player : Player = load(selected[&"scene"]).instantiate()
	player.global_position = self.global_position
	if player_id: player.name = str(player_id)
	get_tree().get_current_scene().add_child.call_deferred(player)
	var new_hud = hud.instantiate()
	new_hud.player = player
	new_hud.avatar = AtlasTexture.new()
	new_hud.avatar.atlas = load(selected[&"image"])
	new_hud.avatar.region.position = Vector2(16, 8)
	new_hud.avatar.region.size = Vector2(32, 32)
	self.add_sibling.call_deferred(new_hud)
	emit_signal("entity_spawned")
