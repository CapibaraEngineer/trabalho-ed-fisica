extends CharacterBody2D

@onready var spawn_point = get_node("../SpawnP1").global_position

const SPEED = 250
const GRAVITY = 1000
const JUMP_SPEED = -400
const MAXIMO_DE_PULOS = 2
var pulos = 0
var forca_corda = Vector2.ZERO

func resetarProSpawn() -> void:
	global_position = spawn_point

func _ready() -> void:
	global_position = spawn_point

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("P1 esquerda", "P1 direita")
	velocity.x = direction * SPEED
	
	if is_on_floor():
		pulos = 0
	else: #not is_on_floor()
		velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("P1 pulo") and pulos < MAXIMO_DE_PULOS:
		pulos += 1
		velocity.y = JUMP_SPEED
	
	velocity += forca_corda
	
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0).get_collider()
		if(collision.name == "SpikeLayer"):
			get_node("../../Level1").resetPlayers()
		
	
