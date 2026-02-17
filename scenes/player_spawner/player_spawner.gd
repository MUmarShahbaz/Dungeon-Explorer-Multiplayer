extends Node2D

enum characters {Knight, Wizard}
var already_used: Array[characters] = []
@export var player_selector : PackedScene


func display_player_selector():
	get_tree().get_current_scene().add_child.call_deferred(player_selector)
