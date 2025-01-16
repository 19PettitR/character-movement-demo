extends Area2D

@onready var timer: Timer = $Timer


func _ready() -> void:
	body_entered.connect(_player_exit)


func _player_exit(_p: Node2D) -> void:
	if PlayerHud.enemies_in_level == 0:
		PlayerHud.announce("You Win!", 1, "green")
		timer.start(3)
		await timer.timeout
		PlayerManager.exit()
	else:
		PlayerHud.announce("code_1")
