extends CanvasLayer

## i hate this get_node business
@onready var health_label: Label = get_node("/root/Node/Player HUD/Control/Health Label")
@onready var charge_label: Label = get_node("/root/Node/Player HUD/Control/Charge Label")
@onready var enemies_label: Label = get_node("/root/Node/Player HUD/Control/Enemies Label")
@onready var important_label: Label = get_node("/root/Node/Player HUD/Control/Important Label")
@onready var full_screen: ColorRect = get_node("/root/Node/Player HUD/Control/Full Screen")
@onready var timer: Timer = get_node("/root/Node/Player HUD/Timer")
@onready var dash_cooldown: ColorRect = get_node("/root/Node/Player HUD/Control/Dash Cooldown") 

var enemies_in_level = 0


func _ready() -> void:
	await get_tree().process_frame
	dash_cooldown.color = "dark orange"
	health_label.text = "Health: " + str(PlayerManager.player.health)


func update_health(h:int) -> void:
	health_label.text = "Health: " + str(h)


func update_charge(c:int) -> void:
	charge_label.text = "Charges: " + str(c)


func add_enemy() -> void:
	
	enemies_in_level += 1
	
	if enemies_in_level == 1:
		enemies_label.text = "1 Enemy Remaining"
	else:
		enemies_label.text = str(enemies_in_level) + " Enemies Remaining"


func remove_enemy() -> void:
	
	enemies_in_level -= 1
	
	if enemies_in_level == 1:
		enemies_label.text = "1 Enemy Remaining"
	elif enemies_in_level == 0:
		enemies_label.text = ""
	else:
		enemies_label.text = str(enemies_in_level) + " Enemies Remaining"


func announce(message: String, time: int = 0, colour: String = "white") -> void:
	
	if message == "code_1":
		
		important_label.text = enemies_label.text
		important_label.modulate = "red"
		
		## take the text off after 1 second
		timer.start(1)
		await timer.timeout
		important_label.text = ""
		
	else:
		important_label.text = message
		important_label.modulate = str(colour)
		full_screen.modulate = "#009ad5"


func start_dash_cooldown() -> void:
	dash_cooldown.color = "dim gray"


func end_dash_cooldown() -> void:
	dash_cooldown.color = "dark orange"
