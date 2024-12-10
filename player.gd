## USING THE GODOT BASIC MOVEMENT BUILT-IN SCRIPT
extends CharacterBody2D


const SPEED = 300.0
## boost from dashing
const DASH_BOOST = 4
const JUMP_VELOCITY = -400.0


## keeps track of whether the player is dashing or not
var is_dashing : bool = false
var dash_cooldown : bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.2
	
	
	## dashing (orange) overrides other colours
	if not is_dashing:
		## play the idle animation if on the floor and not moving
		if is_on_floor() and velocity.x == 0:
			animation_player.play("idle (red)")
		## play the move animation if on the floor and moving
		elif is_on_floor() and velocity.x != 0:
			animation_player.play("move (blue)")
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		## do not turn yellow if dashing
		if not is_dashing:
			animation_player.play("jump (yellow)")
		
		
	## handle dash only if not cooling down
	if Input.is_action_just_pressed("dash") and not dash_cooldown:
		
		animation_player.play("dash (orange)")
		
		## dashing to true during speed increase
		is_dashing = true
		velocity.x = velocity.x * DASH_BOOST
		await get_tree().create_timer(0.2).timeout
		is_dashing = false
		
		## start a dash cooldown to prevent dashing in quick succession
		dash_cooldown = true
		await get_tree().create_timer(1).timeout
		dash_cooldown = false
	
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	## normal movement only if not dashing
	if not is_dashing:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()
