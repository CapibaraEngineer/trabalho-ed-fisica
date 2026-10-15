extends Node2D

func resetPlayers() -> void:
	get_node("Player1").resetarProSpawn()
	get_node("Player2").resetarProSpawn()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
