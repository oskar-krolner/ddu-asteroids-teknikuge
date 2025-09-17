extends CharacterBody2D

signal skud_pewed(skud)


@onready var skyder = $Skyder

var skud_scene = preload("res://skud.tscn")

func _process(delta):
	if Input.is_action_just_pressed("Skyd"):
		skud_pew()




func skud_pew():
	var l = skud_scene.instantiate()
	l.global_position = skyder.global_position
	l.rotation = rotation
	emit_signal("skud_pewed", l)
