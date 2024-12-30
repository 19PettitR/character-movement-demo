extends Node2D

@onready var level = get_node("/root/Node")
var osquare = preload("res://enemies/O_square/O_square.tscn")

## storing the names, speeds, direction, and limits of Osquares in the level
## could probably be achieved with a 2D array, oh well
var names: Array = []
var speeds: Array = []
var left_limits: Array = []
var right_limits: Array = []
var heights: Array = []

## for finding and identifying squares still alive when player dies...
## ...(so the dead ones can be respawned)
var squares_found = 0
var squares_alive = []

## stores the square to be insantiated
var square: O_square


## called by each square to give its details
func receive(name: String, speed: int, left_limit: int, right_limit: int, height: int) -> void:
	names.append(name)
	speeds.append(speed)
	left_limits.append(left_limit)
	right_limits.append(right_limit)
	heights.append(height)


func reload() -> void:
	
	## get the children of the level
	for c in level.get_children():
		## check if the child is an osquare
		if c is O_square:
			squares_found = squares_found + 1
			squares_alive.append(c.name)
	
	## for all the squares that were alive at the start of the level...
	for i in names:
		## if they are not alive at player death...
		if names[i] not in squares_alive:
			## respawn them...
			square = osquare.instantiate()
			square.name = names[i]
			square.speed = speeds[i]
			square.left_limit = left_limits[i]
			square.right_limit = right_limits[i]
			square.height = heights[i]
			level.add_child(osquare)
