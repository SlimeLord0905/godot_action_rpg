extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	global.gamemode = 3
	get_tree().change_scene("res://world.tscn")

func _on_Button2_pressed():
	global.gamemode = 2
	get_tree().change_scene("res://world.tscn")

func _on_Button3_pressed():
	global.gamemode = 1
	get_tree().change_scene("res://world.tscn")
