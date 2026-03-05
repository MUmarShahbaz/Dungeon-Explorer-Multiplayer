extends Node
class_name MultiplayerManager

@export var player_spawners : Array[PlayerSpawner]= []
@export var players_dictionary = []

func host():
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(5555)
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(Callable(self, "add_player"))
	multiplayer.peer_disconnected.connect(Callable(self, "del_player"))
	
	multiplayer.connected_to_server.connect(Callable(self, "connected"))
	
	add_player(1)
	return #get_local_ip()

func join(addr: StringName):
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(addr, 5555)
	multiplayer.multiplayer_peer = client_peer

func add_player(id : int):
	if player_spawners.size() > players_dictionary.size():
		if id == 1: (player_spawners[players_dictionary.size()] as PlayerSpawner).display_player_selector()
		else: (player_spawners[players_dictionary.size()] as PlayerSpawner).display_player_selector.rpc_id(id)
		players_dictionary.append(id)

func connected():
	pass

@rpc("any_peer", "call_local", "reliable")
func start_dialogue(dialogue_sequence : String):
	var my_player : Player = get_tree().current_scene.get_node(str(multiplayer.get_unique_id()))
	if my_player: my_player.disable_controls = true
	var new_dialogue_box := DialogueBox.new()
	get_tree().current_scene.add_child.call_deferred(new_dialogue_box)
	await new_dialogue_box.ready
	await new_dialogue_box.begin_dialogue_from_resource(dialogue_sequence)
	new_dialogue_box.queue_free()
	if my_player: my_player.disable_controls = false
