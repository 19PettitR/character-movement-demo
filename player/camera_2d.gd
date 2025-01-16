
extends Camera2D

@onready var background: TextureRect = get_node("/root/Node/Background")


func _ready() -> void:
	limit_right = background.global_position.x + background.size.x
	limit_left = background.global_position.x
	limit_top = background.global_position.y
	limit_bottom = background.global_position.y + background.size.y
