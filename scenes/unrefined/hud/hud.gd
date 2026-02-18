extends CanvasLayer

@onready var HP_Bar : ProgressBar = $Control/HBoxContainer/HP_Bar
@onready var Healing_Potions : Label = $"Control/HBoxContainer/Healing Potions"
@onready var player : Player = get_tree().get_first_node_in_group("players")

func _process(_delta: float) -> void:
	if player:
		HP_Bar.value = (player.HP_Current / player.HP_Health_Points) * 100
		Healing_Potions.text = str(player.ITM_Healing_Potions)
	else: queue_free()
