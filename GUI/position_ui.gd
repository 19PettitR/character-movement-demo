extends Label

@export var from_top: int = 10
@export var from_right: int = 10

@onready var camera_right = get_node("/root/Node/player/Camera2D").limit_right

func _process(_delta: float) -> void:
	print(camera_right)
