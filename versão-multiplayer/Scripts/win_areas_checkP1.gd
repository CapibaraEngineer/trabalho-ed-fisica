extends Area2D

@onready var gerente = get_node("/root/main/WinAreas")

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player1"):
		return
	if multiplayer.is_server():
		gerente.registrar_vitoria("Player1")
	else:
		gerente.registrar_vitoria.rpc_id(1, "Player1")
