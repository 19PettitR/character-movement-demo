## handles the movement of the osquare
class_name O_square extends CharacterBody2D

@export var speed : int
@export var direction : int = 1
@export var left_limit : int
@export var right_limit : int
@export var height : int

var dead = false
var start_position : Vector2

func _ready() -> void:
	PlayerHud.add_enemy()
	PlayerManager.player_dead.connect(_respawn)
	start_position = self.global_position


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.1
	
	if not dead:
		## going right
		if direction == 1:
			## if position is equal to or further right than right limit, turn left
			if self.global_position.x >= right_limit:
				move_toward(velocity.x, 0, 10)
				direction = -1
			else:
				velocity.x = direction * speed
		## going left
		elif direction == -1:
			## if position is equal to or further left than left limit, turn right
			if self.global_position.x <= left_limit:
				move_toward(velocity.x, 0, 20)
				direction = 1
			else:
				velocity.x = direction * speed
	
	move_and_slide()


func die():
	dead = true
	self.global_position.x = 940
	self.global_position.y = 900
	PlayerHud.remove_enemy()


func _respawn():
	if dead:
		PlayerHud.add_enemy()
		self.global_position = start_position
		dead = false
	pass
