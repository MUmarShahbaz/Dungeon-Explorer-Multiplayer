extends Node2D
class_name PlayerSpawner

signal chatacter_selected

var player_selector : PackedScene = preload("res://scenes/player_spawner/player_selector.tscn")
var hud : PackedScene = preload("res://scenes/unrefined/hud/hud.tscn")


var player_id : int
var selected : Dictionary

func display_player_selector():
	var new_selector = player_selector.instantiate()
	(new_selector.continue_btn as Button).pressed.connect(func ():
		selected = new_selector.selected
		new_selector.queue_free()
		chatacter_selected.emit()
	)
	get_tree().get_current_scene().add_child.call_deferred(new_selector)

func spawn():
	var player : Player = load(selected[&"scene"]).instantiate()
	player.global_position = self.global_position
	if player_id: player.name = str(player_id)
	get_tree().get_current_scene().add_child.call_deferred(player)
	self.add_sibling.call_deferred(hud.instantiate())
