extends Node

func _ready():
<<<<<<< HEAD
	$idlemusic.play()
	$Sprite/MarginContainer/VBoxContainer/TextureButton.grab_focus()

func _physics_process(delta):
	if $Sprite/MarginContainer/VBoxContainer/TextureButton.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/TextureButton.grab_focus()
	
	if $Sprite/MarginContainer/VBoxContainer/TextureButton2.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/TextureButton2.grab_focus()
=======
	$Sprite/MarginContainer/VBoxContainer/Start_btn.grab_focus()

func _physics_process(delta):
	if $Sprite/MarginContainer/VBoxContainer/Start_btn.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/Start_btn.grab_focus()
	if $Sprite/MarginContainer/VBoxContainer/Exit_btn.is_hovered() == true:
		$Sprite/MarginContainer/VBoxContainer/Exit_btn.grab_focus()
>>>>>>> 08ec3178009e23eb53600bfeb734258f910f7be1



func _on_TextureButton_pressed():
	$start.play()
	get_tree().change_scene("res://world.tscn")
	


func _on_TextureButton2_pressed():
	$exit.play()
	get_tree().quit()




func _on_TextureButton2_focus_exited():
	$swipe.play()


func _on_TextureButton_focus_exited():
	$swipe.play()
