extends Control


func _on_host_pressed() -> void:
	$"../../Rede".criar_host()
	queue_free()

func _on_join_pressed() -> void:
	var ip = get_ip()
	if ip == "":
		print("Não foi possivel encontrar o IP da rede")
		return
	$"../../Rede".entrar_no_jogo(ip)
	queue_free()

func get_ip() -> String:
	var ips = IP.get_local_addresses()
	
	for ip in ips:
		if ip.count(".") == 3 and not ip.begins_with("127."):
			print(ip)
			return ip
	return ""
