extends Control

@onready var rede = $"Rede"

func _ready() -> void:
	print("IPs locais encontrados: ", obter_ips_locais())

func _on_host_pressed() -> void:
	rede.criar_host()
	get_tree().change_scene_to_file("res://Cenas/level_1.tscn")

func _on_join_pressed() -> void:
	var ip = obter_ips_locais()
	if ip[0] == "":
		print("Não foi possivel encontrar o IP da rede")
		return
	rede.entrar_no_jogo(ip[0])
	get_tree().change_scene_to_file("res://Cenas/level_1.tscn")

func obter_ips_locais() -> Array[String]:
	var ips: Array[String] = []
	for endereco in IP.get_local_addresses():
		if endereco.contains(":"):
			continue
		if endereco.begins_with("127."):
			continue
		if endereco.begins_with("169.254."):
			continue
		ips.append(endereco)
	return ips
