extends CharacterBody2D

const GRAVITY = 980
const SPEED = 300
const JUMP_VELOCITY = -350


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("P2 esquerda", "P2 direita")
	velocity.x = direction * SPEED
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("P2 pulo") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	move_and_slide()
