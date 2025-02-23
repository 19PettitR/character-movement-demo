## for the osquare. detects if it has been touched and tells the player manager
extends Area2D

@onready var o_square: O_square = $".."

func _ready() -> void:
	body_entered.connect(_call_player_manager)


func _call_player_manager(_p: Node2D) -> void:
	if PlayerManager.player.is_charging:
		o_square.die()
	else:
		PlayerManager.player_damaged(1)
