extends Node

func get_player():
	var player = get_tree().get_first_node_in_group("players")
	while player == null:
		await get_tree().physics_frame
		player = get_tree().get_first_node_in_group("players")
	return player

func new_dialogue(dialogue = null, dialogue_resource = null):
	var player = await get_player()
	player.disable_controls = true
	var new_dialog_box := DialogueBox.new()
	add_child.call_deferred(new_dialog_box)
	await new_dialog_box.ready
	if dialogue: await new_dialog_box.begin_dialogue(dialogue)
	elif dialogue_resource: await new_dialog_box.begin_dialogue_from_resource(dialogue_resource)
	new_dialog_box.queue_free()
	player.disable_controls = false
