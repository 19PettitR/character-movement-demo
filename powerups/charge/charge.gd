## for the charge powerup. detects if it has been touched and tells the player manager
extends Area2D

var used : bool = false
## store original position as a variable so the icon can be moved back when the player dies
var my_position : Vector2


func _ready() -> void:
	my_position = self.global_position
	PlayerManager.player_dead.connect(_respawn)
	body_entered.connect(_call_player_manager)


func _call_player_manager(_p: Node2D) -> void:
	PlayerManager.powerup_collected("charge")
	used = true
	self.global_position.x = 940
	self.global_position.y = 900


func _respawn() -> void:
	if used:
		self.global_position = my_position
		used = false
