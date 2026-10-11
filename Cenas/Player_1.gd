extends CharacterBody2D


const SPEED = 200
const GRAVITY = 980
const JUMP_SPEED = -400
var pulos = 0

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("P1 esquerda", "P1 direita")
	velocity.x = direction * SPEED
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("P1 pulo") and pulos < 1:
		pulos += 1
		velocity.y = JUMP_SPEED
	if is_on_floor():
		pulos = 0
	move_and_slide()
