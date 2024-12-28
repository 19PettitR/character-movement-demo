extends Node

@onready var player: CharacterBody2D = get_node("/root/Node/Player")


func _ready() -> void:
	await get_tree().process_frame


func player_died() -> void:
	player.velocity.x = 0
	player.velocity.y = 0
	player.global_position.x = 125
	player.global_position.y = 550
	player.health = 3
	OSquareManager.reload()


func player_damaged(d: int) -> void:
	if player.health > 0:
		player.health = player.health - d
	if player.health == 0:
		player_died()
	print(player.health)
	pass
