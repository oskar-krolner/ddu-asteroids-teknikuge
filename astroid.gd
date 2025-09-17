extends Node2D

@onready var angreb = $Angreb
@onready var rumskib = $Rumskib

func _ready():
	rumskib.connect("skud_pewed", _on_rumskib_skud_pew)

func _on_rumskib_skud_pew(skud):
	angreb.add_child(skud)
