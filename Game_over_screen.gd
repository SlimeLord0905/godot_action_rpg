extends Node

func _ready():
	$Sprite/MarginContainer/VBoxContainer/btn_retour.grab_focus()

func _physics_process(delta):
	if $Sprite/MarginContainer/VBoxContainer/btn_retour.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/btn_retour.grab_focus()

func _on_TextureButton_pressed():
	get_tree().change_scene("res://World/Title_screen.tscn")


