## handles the movement of the osquare
class_name O_square extends CharacterBody2D

@export var speed : int
@export var direction : int = 1
@export var left_limit : int
@export var right_limit : int
@export var height : int



## sends information to the level manager so can be reloaded upon death
func _ready() -> void:
	self.global_position.x = left_limit
	self.global_position.y = height
	OSquareManager.receive(self.name, speed, left_limit, right_limit, height)


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.1
	
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
