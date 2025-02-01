extends Node

@onready var multiplayer_ui = $UI/Multiplayer

const PLAYER = preload ("res://Characters/Placeholder_Char/smoll_char.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()
var player_name :String = ""

func _on_host_pressed():
	player_name = %EditName.text
	if player_name !="":
		Config.player_name = %EditName.text
	multiplayer_ui.hide()

	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	
	multiplayer.peer_connected.connect(
		func(pid):
			print("Peer " + str(pid) + " has joined the game!")
			add_player(pid)
	)
	
	add_player(multiplayer.get_unique_id())
func _on_join_pressed():
	player_name = %EditName.text
	if player_name !="":
		Config.player_name = %EditName.text
	multiplayer_ui.hide()

	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer

func add_player(pid):
	var player = PLAYER.instantiate()
	player.name = str(pid)
	add_child(player)

	return player
