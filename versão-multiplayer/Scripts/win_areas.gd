extends Node2D

var player1_chegou := false
var player2_chegou := false
var fase_carregando := false

@export var proxima_fase: String

@rpc("any_peer", "call_remote", "reliable")
func registrar_vitoria(jogador: String) -> void:
	if not multiplayer.is_server():
		return
	
	var remetente := multiplayer.get_remote_sender_id()
	
	if jogador == "Player1":
		if remetente != 0 and remetente != 1:
			return
		player1_chegou = true
	elif jogador == "Player2":
		if remetente == 1:
			return
		player2_chegou = true
	else:
		return
	
	print(jogador, " chegou á porta")
	print(player1_chegou)
	print(player2_chegou)
	verificar_vitoria()

func verificar_vitoria() -> void:
	if not multiplayer.is_server():
		return
	if fase_carregando:
		return
	if not player1_chegou:
		return
	if not player2_chegou:
		return

	fase_carregando = true
	print("Os dois jogadores venceram!")
	mudar_fase.rpc()

@rpc("authority", "call_local", "reliable")
func mudar_fase() -> void:
	preload("res://Cenas/level_2.tscn")
	get_tree().call_deferred(
		"change_scene_to_file",
		"res://Cenas/" + proxima_fase + ".tscn"
	)
