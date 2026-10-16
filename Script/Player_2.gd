extends CharacterBody2D

@onready var spawn_point = get_node("../SpawnP2").global_position

#MOVIMENTAÇÃO
const GRAVITY = 1000
const SPEED = 300
const JUMP_VELOCITY = -350
const ESCADA_VELOCIDADE = 150
var direcao_olhando = 0 #facing_direction, pra que direcao o jogador está olhando
var forca_corda = Vector2.ZERO
var na_escada = false

#especificações do dash
const DASH_DURATION = 0.3
const DASH_SPEED = 1000

#controle da habilidade
var pode_dar_dash = true
var dash_timer = 0.0

func entrar_na_escada() -> void:
	na_escada = true

func sair_da_escada() -> void:
	na_escada = false

func resetarProSpawn() -> void:
	na_escada = false
	global_position = spawn_point

func morrer() -> void:
	resetarProSpawn()
	get_node("../Player1").resetarProSpawn()

func _ready() -> void:
	global_position = spawn_point
	
func checarColisaoEspinho() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if(collision.name == "SpikeLayer"):
			morrer()

func _physics_process(delta: float) -> void:
	#Movimentaçao de um lado pro outro
	var direction = Input.get_axis("P2 esquerda", "P2 direita")
	
	# Guardar pra que direcao o player ta olhando
	if direction != 0:
		direcao_olhando = direction
	
	velocity.x = direction * SPEED
	
	#escada
	if na_escada and Input.is_action_pressed("P2 pulo"):
		velocity.y = -ESCADA_VELOCIDADE
	elif is_on_floor():
		pode_dar_dash = true
	else: #not is_on_floor()
		velocity.y += GRAVITY * delta
		
	if not na_escada and Input.is_action_just_pressed("P2 pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# dash
	if Input.is_action_just_pressed("P2 dash") and pode_dar_dash == true:
		dash_timer = DASH_DURATION
		pode_dar_dash = false
	
	if dash_timer > 0.0:
		velocity.x = DASH_SPEED * direcao_olhando
		dash_timer -= delta
		
	velocity += forca_corda
	
	move_and_slide()
	
	checarColisaoEspinho()
