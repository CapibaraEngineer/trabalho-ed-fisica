extends Line2D

@onready var player1 = get_node("../1")
var player2 = null

var conectada = false
var pode_conectar = false
var P1_puxando = false
var P2_puxando = false

const forca_maxima = 100
const forca_puxada = 30
const distancia_corda = 250

func _ready() -> void:
	for candidato in get_parent().get_children():
		if candidato is CharacterBody2D and candidato != player1:
			player2 = candidato
			break

func _physics_process(_delta: float) -> void:
	if not is_multiplayer_authority():
		return
	if not is_instance_valid(player1) or not is_instance_valid(player2):
		return
# Controle dos botões da corda
	P2_puxando = Input.is_action_pressed("P2 puxar corda")
	
	var distancia = player1.global_position.distance_to(player2.global_position)
	
	pode_conectar = distancia <= 200
	
	if Input.is_action_just_pressed("conectar corda"):
		_alternar_conexao()
	
	# Mostrar a corda
	if conectada:
		clear_points()
		add_point(player1.global_position)
		add_point(player2.global_position)
		show()
	else:
		hide()
	
	var direcao = (
		player2.global_position - player1.global_position
	).normalized()
	
	var forca_p1 = Vector2.ZERO
	var forca_p2 = Vector2.ZERO
	
	if conectada and distancia > distancia_corda:
		forca_p1 = direcao * forca_maxima /2.3
		forca_p2 = -direcao * forca_maxima
	elif conectada and P1_puxando and distancia > 60:
		forca_p2 = -direcao * forca_puxada
	elif conectada and P2_puxando and distancia > 60:
		forca_p1 = direcao * forca_puxada
	
	_aplicar_forca(player1, forca_p1)
	_aplicar_forca(player2, forca_p2)

func _alternar_conexao() -> void:
	if conectada:
		conectada = false
	elif pode_conectar:
		conectada = true

@rpc("any_peer", "call_remote", "reliable")
func receber_estado_p1(pressionado: bool) -> void:
	if not is_multiplayer_authority():
		return
	if multiplayer.get_remote_sender_id() != 1:
		return
	P1_puxando = pressionado

@rpc("any_peer", "call_remote", "reliable")
func solicitar_alternar_conexao() -> void:
	if not is_multiplayer_authority():
		return
	if multiplayer.get_remote_sender_id() != 1:
		return
	_alternar_conexao()

func _aplicar_forca(jogador, valor: Vector2) -> void:
	if jogador.is_multiplayer_authority():
		jogador.forca_corda = valor
	else:
		jogador.rpc_id(
			jogador.get_multiplayer_authority(), 
			"receber_forca_corda",
			valor
		)
