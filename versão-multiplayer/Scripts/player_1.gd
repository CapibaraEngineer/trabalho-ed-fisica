extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var forca_corda = Vector2.ZERO

var pulos: int = 0
const max_pulos: int = 2

const ESCADA_VELOCIDADE = 150
var na_escada = false

var p1_puxando_anterior := false

@onready var spawn_point = get_node("../../SpawnPointP1")

func change_velocity(newV: Vector2):
	velocity += newV

@rpc("any_peer", "call_local", "reliable")
func entrar_na_escada() -> void:
	if not is_multiplayer_authority():
		return
	na_escada = true

@rpc("any_peer", "call_local", "reliable")
func sair_da_escada() -> void:
	if not is_multiplayer_authority():
		return
	na_escada = false

@rpc("any_peer", "call_remote", "reliable")
func resetarProSpawn() -> void:
	na_escada = false
	if(spawn_point != null):
		global_position = spawn_point.global_position
	else:
		print("Spawn point invalido do P1!")


func morrer() -> void:
	resetarProSpawn()
	var jogadores = get_node("../../Jogadores")
	for player in jogadores.get_children():
		var sync = player.get_node("MultiplayerSynchronizer")
		if sync.get_multiplayer_authority() != 1:
			player.resetarProSpawn.rpc_id(
				player.get_multiplayer_authority()
			)
			break

func checarColisaoEspinho() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if(collision.name == "SpikeLayer"):
			morrer()

func _ready() -> void:
	if spawn_point == null:
		print("Spawn point invalido do P1!")
	resetarProSpawn()

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	_enviar_estado_corda()

	if na_escada and Input.is_action_pressed("ui_up"):
		velocity.y = -ESCADA_VELOCIDADE
	elif is_on_floor():
		pulos = 0
	else: #not is_on_floor()
		if pulos == 0:
			pulos = 1
		velocity += get_gravity() * delta

	if not na_escada and Input.is_action_just_pressed("ui_up") and pulos < max_pulos:
		pulos += 1
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	velocity += forca_corda

	velocity += forca_corda
	move_and_slide()
	checarColisaoEspinho()

func _enviar_estado_corda() -> void:
	var corda_node = get_parent().get_node_or_null("Corda")
	
	if corda_node == null:
		return
	var puxando = Input.is_action_pressed("P1 puxar corda")
	if puxando != p1_puxando_anterior:
		corda_node.rpc_id(
			corda_node.get_multiplayer_authority(),
			"receber_estado_p1",
			puxando
		)
		p1_puxando_anterior = puxando


@rpc("any_peer", "call_remote", "unreliable_ordered")
func receber_forca_corda(valor: Vector2) -> void:
	if not is_inside_tree():
		return
	if not is_multiplayer_authority():
		return
	var corda_node = get_parent().get_node_or_null("Corda")
	if corda_node == null:
		return
	if multiplayer.get_remote_sender_id() != corda_node.get_multiplayer_authority():
		return
	forca_corda = valor
