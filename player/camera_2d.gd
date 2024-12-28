extends Camera2D

@onready var player: CharacterBody2D = $".."
@onready var background: TextureRect = get_node("/root/Node/Background")

## max limits for the camera for each direction
var max_limit_right : int
var max_limit_left : int
var max_limit_top : int
var max_limit_bottom : int

var player_position : Vector2

## temporarily holds the limit for each side of the camera
var potential_limit : int

## variables are being set in the process function, since they require onready
## so this is used to keep track of whether they have been set or not
var variables_set : bool = false


func _process(_delta: float) -> void:
	
	## maximum limits for the camera. not good that these are set each 'delta'
	max_limit_right = background.global_position.x + background.size.x
	max_limit_left = background.global_position.x
	max_limit_top = background.global_position.y
	max_limit_bottom = background.global_position.y + background.size.y
	
	player_position = player.global_position
	
	## find right limit
	potential_limit = player_position.x + 540
	if potential_limit < max_limit_right:
		limit_right = potential_limit
	else:
		limit_right = max_limit_right
	
	limit_bottom = max_limit_bottom

	
