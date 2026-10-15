extends CharacterBody2D
#MOVIMENTAÇÃO
const GRAVITY = 1000
const SPEED = 300
const JUMP_VELOCITY = -350
var forca_corda = Vector2.ZERO

#especificações do dash
const DASH_DURATION = 0.3
const DASH_SPEED = 1000

#controle da habilidade
var pode_dar_dash = true
var dash_timer = 0.0
var direcao_atual = 0
var estava_no_ar = false

func _physics_process(delta: float) -> void:
	#movimentaçao de um lado pro outro
	var direction = Input.get_axis("P2 esquerda", "P2 direita")
	if is_on_floor():
		velocity.x = direction * SPEED

	#pulo
	if not is_on_floor():
		estava_no_ar = true
		velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("P2 pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# dash
	if direction != 0:
		direcao_atual = direction
	if Input.is_action_just_pressed("P2 dash") and pode_dar_dash == true:
		dash_timer = DASH_DURATION
		pode_dar_dash = false
	if dash_timer > 0.0:
		velocity.x = DASH_SPEED * direcao_atual
		dash_timer -= delta
	else:
		velocity.x = direction * SPEED
		
	velocity += forca_corda
	move_and_slide()
	if estava_no_ar and is_on_floor():
		estava_no_ar = false
		pode_dar_dash = true
