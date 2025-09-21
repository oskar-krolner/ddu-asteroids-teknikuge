extends Node2D

@onready var angreb = $Angreb
@onready var rumskib = $Spiller
@onready var asteroids = $asteroids
@onready var hud = $UI/HUD
@onready var player_spawn_pos = $playerspawnpos
@onready var asteroids2 = $asteroids/Node2D/asteroids2

var asteroid_scene = preload("res://asteroid.tscn")

var score := 0:
	set(value):
		score = value
		hud.score = score

var lives = 3:
	set(value):
		lives = value
		hud.init_lives(lives)

func _ready():
	score = 0
	lives = 3
	rumskib.connect("skud_pewed", _on_rumskib_skud_pew)
	rumskib.connect("died", _on_player_died)
	for asteroid in asteroids.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)


func _on_rumskib_skud_pew(skud):
	angreb.add_child(skud)
	$laserpewpewnoise.play()



func _on_asteroid_exploded(pos, size, points):
	$eksplosion_lyd.play()
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
		
@onready var Player =$Spiller
	
	
	
	


func spawn_asteroid(pos, size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded", _on_asteroid_exploded)
	asteroids.call_deferred("add_child", a)

func _on_player_died():
	lives -= 1
	if lives <=0:
		get_tree().reload_current_scene()
	else:
		await get_tree().create_timer(1).timeout
		Player.respawn(player_spawn_pos.global_position)
	


func _on_timer_timeout() -> void:
	for asteroid in asteroids2.get_children():
		asteroid.connect("exploded", _on_asteroid_exploded)
