## manages player health and powerups
extends Node

@onready var player: CharacterBody2D = get_node("/root/Node/Player")
signal player_dead

func _ready() -> void:
	await get_tree().process_frame


func player_died() -> void:
	player_dead.emit()
	
	player.velocity.x = 0
	player.velocity.y = 0
	
	player.global_position.x = 125
	player.global_position.y = 550
	
	player.health = 3
	player.charges = 0
	
	PlayerHud.update_health(player.health)
	PlayerHud.update_charge(player.charges)


func player_damaged(d: int) -> void:
	
	if player.health > 0:
		player.health = player.health - d
	if player.health == 0:
		player_died()
		return
	PlayerHud.update_health(player.health)
	
	## 'knockback' system. not very good
	player.velocity.x = -player.knockback_speed
	player.velocity.y = -player.knockback_speed


func powerup_collected(powerup: String) -> void:
	if powerup == "charge":
		player.charges = player.charges + 1
		PlayerHud.update_charge(player.charges)


func exit() -> void:
	## this crashes the game, but it does the job
	get_tree().quit()
