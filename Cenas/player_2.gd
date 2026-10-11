extends CharacterBody2D

const GRAVITY = 980
const SPEED = 300
const JUMP_VELOCITY = -350
const AIR_SPEED = 500
var pulo_longo = false


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("P2 esquerda", "P2 direita")
	if is_on_floor():
		velocity.x = direction * SPEED
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("P2 pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		pulo_longo = true
	if pulo_longo == true:
		velocity.x = direction * AIR_SPEED
	else:
		velocity.x = direction * SPEED
		
	move_and_slide()
	
	if is_on_floor():
		pulo_longo = false
