extends Node2D

var osquare = preload("res://enemies/O_square/O_square.tscn")

## storing the names, speeds, direction, and limits of Osquares in the level
## could probably be achieved with a 2D array, oh well
var names: Array = []
var speeds: Array = []
var left_limits: Array = []
var right_limits: Array = []
var heights: Array = []

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
	## for each name given, create a new Osquare and give it properties based on corresponding index
	## ...in the other arrays
	for i in range(0, len(names)):
		square = osquare.instantiate()
		square.name = names[i]
		square.speed = speeds[i]
		square.left_limit = left_limits[i]
		square.right_limit = right_limits[i]
		square.height = heights[i]
