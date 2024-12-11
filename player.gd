## USING THE GODOT BASIC MOVEMENT BUILT-IN SCRIPT
extends CharacterBody2D


const SPEED = 300.0
## boost from dashing
const DASH_BOOST = 5
const JUMP_VELOCITY = -400.0


## keeps track of whether the player is dashing or not
var is_dashing : bool = false
var dash_cooldown : bool = false
## track which direction the player was last facing so they can dash in correct direction when idle
var last_facing_right : bool = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 1.2
	
	
	## dashing (orange) overrides other colours
	if not is_dashing:
		## play the idle animation only if on the floor and not moving
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
		
		## if the player dashes whilst idle, find which direction they were facing
		if velocity.x == 0:
			if last_facing_right:
				velocity.x = SPEED * DASH_BOOST
			else:
				velocity.x = SPEED * DASH_BOOST * -1
		else:
			velocity.x = velocity.x * DASH_BOOST
		
		## start a dash cooldown
		dash_cooldown = true
		## dashing for 0.2 seconds
		await get_tree().create_timer(0.2).timeout
		is_dashing = false
		## cool down lasts 1.2 seconds total
		await get_tree().create_timer(1).timeout
		dash_cooldown = false
	
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	## normal movement only if not dashing
	if not is_dashing:
		if direction:
			velocity.x = direction * SPEED
		else:
			## find whether the player is dashing or not and decelerate more when they are
			if is_dashing:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED * 100)
	
	## when a direction key is pressed, track which direction the player is facing for dash
	if Input.is_action_just_pressed("right"):
		last_facing_right = true
	if Input.is_action_just_pressed("left"):
		last_facing_right = false
	
	
	move_and_slide()
