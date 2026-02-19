extends Node2D
class_name PlayerSpawner

var disabled_characters: Array[StringName] = ["DWARF", "SAMURAI"]
var player_selector : PackedScene = preload("res://scenes/player_spawner/player_selector.tscn")
var hud : PackedScene = preload("res://scenes/unrefined/hud/hud.tscn")

var knight : PackedScene = preload("res://scenes/characters/knight.tscn")
var wizard : PackedScene = preload("res://scenes/characters/wizard.tscn")
var dwarf : PackedScene
var samurai : PackedScene

func _ready() -> void:
	display_player_selector()

func display_player_selector():
	var new_selector = player_selector.instantiate()
	for this_character in disabled_characters:
		(new_selector.playable as Array).erase(this_character)
	(new_selector.continue_btn as Button).pressed.connect(func ():
		var player : Player
		match new_selector.selected:
			"KNIGHT":
				player = knight.instantiate()
			"WIZARD":
				player = wizard.instantiate()
			"DWARF":
				player = dwarf.instantiate()
			"SAMURAI":
				player = samurai.instantiate()
		new_selector.queue_free()
		player.global_position = self.global_position
		get_tree().get_current_scene().add_child.call_deferred(player)
		self.add_sibling.call_deferred(hud.instantiate())
		self.queue_free()
	)
	get_tree().get_current_scene().add_child.call_deferred(new_selector)
