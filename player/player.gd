## USING THE GODOT BASIC MOVEMENT BUILT-IN SCRIPT
class_name Player extends CharacterBody2D

@export var health: int = 3

@export_category("Movement")
@export var speed = 300.0
@export var jump_velocity = -420.0
@export var gravity_multiplier = 0.8
@export var knockback_speed = 400.0

@export_category("Dash")
@export var dash_boost = 5
@export var dash_deceleration_multiplier = 100
@export var dash_gravity_multiplier = 0.2

var charges = 0
## keeps track of whether the player is dashing/charging
var is_dashing : bool = false
var is_charging : bool = false
var dash_cooldown : bool = false
## track which direction the player was last facing so they can dash in correct direction when idle
var last_facing_right : bool = true


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		## decrease the gravity if dashing (because it looks better)
		if not is_dashing:
			velocity += get_gravity() * delta * gravity_multiplier
		else:
			velocity += get_gravity() * delta * dash_gravity_multiplier
	
	
	## dashing (orange) overrides other colours
	if not is_dashing:
		## play the idle animation only if on the floor and not moving
		if is_on_floor() and velocity.x == 0:
			animation_player.play("idle (red)")
		## play the move animation if on the floor and moving
		elif is_on_floor() and velocity.x != 0 and not is_charging:
			animation_player.play("move (blue)")
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		## do not turn yellow if dashing
		if not is_dashing and not is_charging:
			animation_player.play("jump (yellow)")
		
		
	## handle dash only if not already dashing, not cooling down and not charging
	if Input.is_action_just_pressed("dash") and not is_dashing and not dash_cooldown and not is_charging:
		
		PlayerHud.start_dash_cooldown()
		
		## dashing to true during speed increase
		is_dashing = true
		animation_player.play("dash (orange)")
		
		## if the player dashes whilst idle, find which direction they were facing
		if velocity.x == 0:
			if last_facing_right:
				velocity.x = speed * dash_boost
			else:
				velocity.x = speed * dash_boost * -1
		else:
			velocity.x = velocity.x * dash_boost
		
		## start a dash cooldown
		dash_cooldown = true
		## dashing for 0.2 seconds
		await get_tree().create_timer(0.2).timeout
		is_dashing = false
		## if the player jumped whilst dashing, turn yellow once dash is over
		if not is_on_floor():
			animation_player.play("jump (yellow)")
		## cool down lasts 1.2 seconds total
		await get_tree().create_timer(1).timeout
		PlayerHud.end_dash_cooldown()
		dash_cooldown = false
	
	## handle charging
	if Input.is_action_just_pressed("charge") and not is_dashing and not is_charging and charges > 0:
		
		charge()
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	## normal movement only if not dashing
	if not is_dashing and not is_charging:
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, 50)
	
	## when a direction key is pressed, track which direction the player is facing for dash
	if Input.is_action_just_pressed("right"):
		last_facing_right = true
	if Input.is_action_just_pressed("left"):
		last_facing_right = false
	
	move_and_slide()


func charge() -> void:
	
	animation_player.play("charge (pink)")
	is_charging = true
	
	charges = charges - 1
	
	if velocity.x == 0:
		if last_facing_right:
			velocity.x = speed * dash_boost
		else:
			velocity.x = speed * dash_boost * -1
	else:
		velocity.x = velocity.x * dash_boost
	
	await get_tree().create_timer(0.2).timeout
	is_charging = false
	## if the player jumped whilst charging, turn yellow once dash is over
	if not is_on_floor():
		animation_player.play("jump (yellow)")
		
	PlayerHud.update_charge(charges)
