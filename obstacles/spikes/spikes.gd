extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	body_entered.connect(_call_player_manager)


func _call_player_manager(_p: Node2D) -> void:
	animation_player.play("touched")
	animation_player.queue("RESET")
	PlayerManager.player_damaged(1)
