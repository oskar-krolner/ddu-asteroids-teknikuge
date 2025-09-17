extends Area2D

var movement_vector := Vector2(0, -1)

enum asteroidsize{large, medium, small, tiny}
@export var size := asteroidsize.large

var speed := 50

@onready var sprite = $Sprite2D


func _ready():
	rotation = randf_range(0, 2*PI )
	
	match size:
		asteroidsize.large:
			speed = randf_range(50, 100)
			sprite.texture = preload("res://asteroid big.png")
		asteroidsize.medium:
			speed = randf_range(100, 150)
			sprite.texture = preload("res://asteroid medium.png")
		asteroidsize.small:
			speed = randf_range(100, 200)
			sprite.texture = preload("res://asteroid small.png")
		asteroidsize.tiny:
			speed = randf_range(150, 200)
			sprite.texture = preload("res://asteroid tiny.png")
		



func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta
	
	
