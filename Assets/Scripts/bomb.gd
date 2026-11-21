extends Node

var seconds = 30

@export var tillboom : Label
@export var exp : Sprite2D
@export var badexp : Area2D

func _ready():
	while seconds > 0:
		seconds -= 1
		tillboom.text = str(seconds) + " s until an explosion"
		await get_tree().create_timer(1).timeout
		
	while true:
		exp.scale.x *= 2
		exp.scale.y *= 2
		badexp.scale.y *= 1.01
		badexp.scale.y *= 1.01
		await get_tree().create_timer(0.01).timeout
