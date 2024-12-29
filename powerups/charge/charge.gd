extends Area2D

func _ready() -> void:
	body_entered.connect(_call_player_manager)


func _call_player_manager(_p: Node2D) -> void:
	PlayerManager.powerup_collected("charge")
	queue_free()
