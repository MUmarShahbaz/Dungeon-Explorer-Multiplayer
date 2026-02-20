extends Node2D
class_name PlayerSpawner

var disabled_characters: Array[StringName] = ["SAMURAI", "NINJA"]
var player_selector : PackedScene = preload("res://scenes/player_spawner/player_selector.tscn")
var hud : PackedScene = preload("res://scenes/unrefined/hud/hud.tscn")

var selected : Dictionary

func _ready() -> void:
	display_player_selector()

func display_player_selector():
	var new_selector = player_selector.instantiate()
	for this_character in disabled_characters:
		(new_selector.playable as Array).erase(this_character)
	(new_selector.continue_btn as Button).pressed.connect(func ():
		selected = new_selector.selected
		new_selector.queue_free()
		spawn()
	)
	get_tree().get_current_scene().add_child.call_deferred(new_selector)

func spawn():
	var player : Player = load(selected[&"scene"]).instantiate()
	player.global_position = self.global_position
	get_tree().get_current_scene().add_child.call_deferred(player)
	self.add_sibling.call_deferred(hud.instantiate())
