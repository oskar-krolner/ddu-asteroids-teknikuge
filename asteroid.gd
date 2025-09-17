extends Area2D

var movement_vector := Vector2(0, -1)

enum asteroidsize{large, medium, small, tiny}
@export var size := asteroidsize.large

var speed := 50

@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D


func _ready():
	rotation = randf_range(0, 2*PI )
	
	match size:
		asteroidsize.large:
			speed = randf_range(50, 100)
			sprite.texture = preload("res://asteroid big.png")
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
	
	
	var screen_size = get_viewport_rect().size
	if global_position.y <0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	
