class_name asteroid extends Area2D

signal exploded (pos, size, points)

var movement_vector := Vector2(0, -1)

enum asteroidsize{large, medium, small, tiny}
@export var size := asteroidsize.large

var speed := 50

@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

var points: int:
	get:
			match size:
				asteroidsize.large:
					return 20
				asteroidsize.medium:
					return 15
				asteroidsize.small:
					return 10
				asteroidsize.tiny:
					return 5
				_:
					return 0
func _ready():
	rotation = randf_range(0, 2*PI )
	
	match size:
		asteroidsize.large:
			speed = randf_range(50, 100)
			sprite.texture = preload("res://asteroid large.png")
			cshape.shape = preload("res://resources/astroid_cshape_large.tres")
		asteroidsize.medium:
			speed = randf_range(100, 150)
			sprite.texture = preload("res://asteroid medium.png")
			cshape.shape = preload("res://resources/asteroid_cshape_medium.tres")
		asteroidsize.small:
			speed = randf_range(100, 200)
			sprite.texture = preload("res://asteroid small.png")
			cshape.shape = preload("res://resources/asteroid_cshape_small.tres")
		asteroidsize.tiny:
			speed = randf_range(150, 200)
			sprite.texture = preload("res://asteroid tiny.png")
			cshape.shape = preload("res://resources/asteroid_cshape_tiny.tres")
		



func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	
	var radius =cshape.shape.radius
	var screen_size = get_viewport_rect().size
	if (global_position.y+radius) <0:
		global_position.y = (screen_size.y+radius)
	elif (global_position.y-radius) > screen_size.y:
		global_position.y = -radius
	if (global_position.x+radius) <0:
		global_position.x = (screen_size.x+radius)
	elif (global_position.x-radius) > screen_size.x:
		global_position.x = -radius

func explode():
	emit_signal("exploded", global_position, size, points)
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var Player =body
		Player.die()
