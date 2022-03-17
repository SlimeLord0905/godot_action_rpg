extends Node

func _ready():
	$Sprite/MarginContainer/VBoxContainer/Start_btn.grab_focus()

func _physics_process(delta):
	if $Sprite/MarginContainer/VBoxContainer/Start_btn.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/Start_btn.grab_focus()
	if $Sprite/MarginContainer/VBoxContainer/Exit_btn.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/Exit_btn.grab_focus()


func _on_TextureButton_pressed():
	get_tree().change_scene("res://world.tscn")


func _on_TextureButton2_pressed():
	get_tree().quit()
