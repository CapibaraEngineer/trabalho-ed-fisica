extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("entrar_na_escada"):
		if body.is_multiplayer_authority():
			body.entrar_na_escada()
		else:
			body.entrar_na_escada.rpc_id(
				body.get_multiplayer_authority()
			)

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("sair_da_escada"):
		if body.is_multiplayer_authority():
			body.sair_da_escada()
		else:
			body.sair_da_escada.rpc_id(
				body.get_multiplayer_authority()
			)
