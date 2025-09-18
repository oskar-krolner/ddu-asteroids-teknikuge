extends Control

@onready var score = $Scorecount:
	set(value):
		score.text = "SCORE:" + str(value)

 
