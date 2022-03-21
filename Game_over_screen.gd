extends Node

func _ready():
	$Sprite/MarginContainer/VBoxContainer/TextureButton.grab_focus()

func _physics_process(delta):
	if $Sprite/MarginContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/TextureButton.grab_focus()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://World/Title_screen.tscn")


