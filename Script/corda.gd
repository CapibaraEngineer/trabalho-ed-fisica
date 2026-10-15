extends Node2D

@onready var player1 = get_node("../Player1")
@onready var player2 = get_node("../Player2")
@onready var linha = $Line2D

var conectada = false
var pode_conectar = false
const forca_maxima = 80
const distancia_corda = 400

func _process(delta: float) -> void:
	#input pra corda conectar
	if conectada == false:
		linha.hide()
	else:
		linha.clear_points()
		linha.add_point(player1.global_position)
		linha.add_point(player2.global_position)
		linha.show()
		
	var distance = player1.global_position.distance_to(player2.global_position)
	if distance <= 200:
		pode_conectar = true
	else:
		pode_conectar = false
		
	if Input.is_action_just_pressed("conectar corda"):
		if conectada:
			conectada = false
			player1.forca_corda = Vector2.ZERO
			player2.forca_corda = Vector2.ZERO
		elif pode_conectar:
			conectada = true
	#fisica da corda
	if conectada == true and distance > distancia_corda:
		var direcao = (player2.global_position - player1.global_position).normalized()
		player1.forca_corda = direcao * forca_maxima
		player2.forca_corda = (direcao * forca_maxima) *  -1
