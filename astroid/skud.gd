extends Area2D

var move_vector = Vector2(0, -1)
var bulletspeed = 200

func _physics_process(delta: float) -> void:
	global_position += move_vector.rotated(rotation) * bulletspeed * delta




func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("deleting " + name)
	queue_free()
