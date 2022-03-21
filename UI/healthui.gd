extends Control


var hearts = 4 setget set_hearts
var max_heart = 4 setget set_max_hearts

onready var heartui_full = $heartui_full
onready var heartui_empty = $heartui_empty

func set_hearts(value):
	hearts = clamp(value,0,max_heart)
	if heartui_full != null:
		heartui_full.rect_size.x = hearts * 15
		
func set_max_hearts(value):
	max_heart = max(value, 1)
	if heartui_empty != null:
		heartui_empty.rect_size.x = max_heart * 15
		
func _ready():
	self.max_heart = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_hearts")
	
