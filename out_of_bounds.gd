extends Area2D

## connect _call_player_manager to the body_entered signal so it runs when the player enters the red
func _ready() -> void:
	body_entered.connect(_call_player_manager)


func _call_player_manager(_p: Node2D) -> void:
	PlayerManager.player_died()
