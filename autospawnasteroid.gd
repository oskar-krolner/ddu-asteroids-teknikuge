extends Node2D

@onready var asteroids = $asteroids2

var asteroid_scene = preload("res://asteroid.tscn")


func _on_timer_timeout() -> void:
	var l = asteroid_scene.instantiate()
	for i in randf_range(0, 4):
		var screenSize = get_viewport().get_visible_rect().size
		var x = randf_range(0, screenSize.x)
		var y = randf_range(0, screenSize.y)
		l.global_position = Vector2(x, y)
		asteroids.add_child(l)
