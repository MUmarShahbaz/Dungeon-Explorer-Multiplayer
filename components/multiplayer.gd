extends Node

var player_container : Node2D
var selector : PackedScene = load("res://scenes/player_spawner/player_selector.tscn")
var hud : PackedScene = preload("res://scenes/player_spawner/hud.tscn")

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
	players_dictionary.append(id)
	if id == 1: display_selector()
	else: display_selector.rpc_id(id)
	$Spawner.begin()

func connected():
	pass

@rpc("authority", "call_remote", "reliable")
func display_selector():
	var new_selector = selector.instantiate()
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
	player_container.add_child.call_deferred(new_player)
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
