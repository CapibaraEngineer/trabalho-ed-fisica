extends CharacterBody2D

var jogador_id: int = 0

func configurar(id: int):
	jogador_id = id
	name = str(id)
	
	print("Personagem criado para o jogador: ", jogador_id)
