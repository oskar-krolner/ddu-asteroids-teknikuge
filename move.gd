extends Node2D

@onready var angreb = $Angreb
@onready var rumskib = $Spiller
@onready var asteroids = $asteroids
@onready var hud = $UI/HUD

var asteroid_scene = preload("res://asteroid.tscn")

var score := 0:
	set(value):
		score = value
		hud.score = score


func _ready():
	score = 0
	rumskib.connect("skud_pewed", _on_rumskib_skud_pew)
	
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)

func _on_rumskib_skud_pew(skud):
	angreb.add_child(skud)



func _on_asteroid_exploded(pos, size, points):
	score += points
	for i in range(2):
		match size:
			asteroid.asteroidsize.large:
				spawn_asteroid(pos, asteroid.asteroidsize.medium)
			asteroid.asteroidsize.medium:
				spawn_asteroid(pos, asteroid.asteroidsize.small)
			asteroid.asteroidsize.small:
				spawn_asteroid(pos, asteroid.asteroidsize.tiny)
			asteroid.asteroidsize.tiny:
				pass
		
	
	
	
	


func spawn_asteroid(pos, size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", a)
