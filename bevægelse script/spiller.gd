class_name Player extends CharacterBody2D

@export var acceleration := 10
@export var max_speed := 300

func _physics_process(delta):
	var input_vector := Vector2(0, Input.get_axis("Fremad", "Tilbage"))
	velocity += input_vector.rotated(rotation) * acceleration
	velocity = velocity.limit_length(max_speed)
	
	if Input.is_action_pressed("Roter_Højre"):
		rotate(5*delta)
	if Input.is_action_pressed("Roter_Venstre"):
		rotate(-5*delta)
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 1)
		
	move_and_slide()
	
	var skærmstørrelsen = get_viewport_rect().size
	if global_position.y < 0:
		global_position.y = skærmstørrelsen.y
	elif global_position.y > skærmstørrelsen.y:
		global_position.y = 0
	
	if global_position.x < 0:
		global_position.x = skærmstørrelsen.x
	elif global_position.x > skærmstørrelsen.x:
		global_position.x = 0


signal skud_pewed(skud)
signal died
var alive = true
@onready var skyder = $Skyder
@onready var sprite = $Sprite2D


var skud_scene = preload("res://skud.tscn")

func _process(delta):
	if Input.is_action_just_pressed("Skyd"):
		skud_pew()




func skud_pew():
	var l = skud_scene.instantiate()
	l.global_position = skyder.global_position
	l.rotation = rotation
	emit_signal("skud_pewed", l)

func die():
	if alive == true:
		alive = false
		emit_signal("died")
		sprite.visible = false
		process_mode = Node.PROCESS_MODE_DISABLED

func respawn(pos):
	if alive ==false:
		alive = true
		global_position = pos
		velocity = Vector2.ZERO
		sprite.visible = true
		process_mode = Node.PROCESS_MODE_INHERIT
