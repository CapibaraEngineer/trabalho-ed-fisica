extends Node

const PORTA: int = 7000
const MAX_PLAYERS: int = 2

@export var cena_jogador: PackedScene
@onready var jogadores: Node2D = $"../Jogadores"

func _ready() -> void:
	multiplayer.connected_to_server.connect(_ao_conectar)
	multiplayer.connection_failed.connect(_ao_falhar)
	multiplayer.server_disconnected.connect(_ao_desconectar)
	multiplayer.peer_connected.connect(_jogador_conectado)
	multiplayer.peer_disconnected.connect(_jogador_desconectado)

func criar_host():
	var peer = ENetMultiplayerPeer.new()
	
	var err = peer.create_server(PORTA, MAX_PLAYERS - 1)
	
	if err != OK:
		print("Erro ao criar o servidor: ", err)
		return
	
	multiplayer.multiplayer_peer = peer
	print("Servidor criado: ", peer)
	
	criar_jogador(multiplayer.get_unique_id())

func entrar_no_jogo(ip: String):
	var peer = ENetMultiplayerPeer.new()
	
	var err = peer.create_client(ip, PORTA)
	
	if err != OK:
		print("Erro ao iniciar conexão: ", err)
		return
	
	multiplayer.multiplayer_peer = peer
	print("Tentando conectar...")

func _ao_conectar():
	print("Conexão com o servidor estabelecida!")

func _ao_falhar():
	print("Não foi possível conectar ao servidor.")

func _ao_desconectar():
	print("Conexão com o servidor perdida.")

func _jogador_conectado(id: int):
	print("Jogador conectado. ID: ", id)
	if not multiplayer.is_server():
		return
	criar_jogador(id)

func _jogador_desconectado(id : int):
	if not multiplayer.is_server():
		return
	var personagem = jogadores.get_node_or_null(str(id))
	if personagem:
		personagem.queue_free()

	print("Jogador desconectado. ID: ", id)

func criar_jogador(id: int):
	if not multiplayer.is_server():
		return
	if jogadores.has_node(str(id)):
		return
	
	var personagem = cena_jogador.instantiate()
	personagem.name = str(id)
	personagem.position = Vector2(100 + jogadores.get_child_count() * 80, 100)
	
	jogadores.add_child(personagem, true)
	
	personagem.configurar(id)
	print("Personagem criado: ", id)
