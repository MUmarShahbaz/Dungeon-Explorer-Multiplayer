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
