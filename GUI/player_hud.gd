extends CanvasLayer

@onready var health_label: Label = get_node("/root/Node/Player HUD/Control/Health Label")
@onready var charge_label: Label = get_node("/root/Node/Player HUD/Control/Charge Label")
@onready var enemies_label: Label = get_node("/root/Node/Player HUD/Control/Enemies Label")

var enemies_in_level = 0


func _ready() -> void:
	await get_tree().process_frame
	health_label.text = "Health: " + str(PlayerManager.player.health)


func update_health(h:int) -> void:
	health_label.text = "Health: " + str(h)


func update_charge(c:int) -> void:
	charge_label.text = "Charges: " + str(c)


func add_enemy() -> void:
	enemies_in_level += 1
	enemies_label.text = "Enemies Remaining: " + str(enemies_in_level)


func remove_enemy() -> void:
	enemies_in_level -= 1
	enemies_label.text = "Enemies Remaining: " + str(enemies_in_level)
