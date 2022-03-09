extends Node

func _ready():
	$Sprite/MarginContainer/VBoxContainer/TextureButton.grab_focus()

func _physics_process(delta):
	if $Sprite/MarginContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/TextureButton.grab_focus()
	if $Sprite/MarginContainer/VBoxContainer/TextureButton2.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/TextureButton2.grab_focus()


func _on_TextureButton_pressed():
	get_tree().change_scene("res://world.tscn")


func _on_TextureButton2_pressed():
	get_tree().quit()
