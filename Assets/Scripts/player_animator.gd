extends Node2D

@export var player_controller : PlayerController
@export var sprite : AnimatedSprite2D

var squash_multiplier = 0.999
var played_fall = true
var playing_fall = false
var is_on_wall = false
var walljump_timer = 0.0
var dashtimer = 0.0
var dashed = false

func _physics_process(delta):
	if walljump_timer > 0:
		walljump_timer -= delta
		
	if dashtimer > 0:
		dashtimer -= delta
		
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true


	if player_controller.is_on_wall():
		if player_controller.wall_jumped and walljump_timer <= 0:
			sprite.play("walljump")
			walljump_timer = 0.5
			is_on_wall = true
			player_controller.wall_jumped = false
		elif walljump_timer <= 0:
			sprite.play("holding_wall")
			is_on_wall = true
	elif abs(player_controller.velocity.x) > 0.0 and player_controller.is_on_floor():
		is_on_wall = false
		dashed = false
		sprite.scale.x = 1
		squash_multiplier = 0.999
		sprite.play("run")
	elif abs(player_controller.velocity.x) <= 0.0 and player_controller.is_on_floor():
		is_on_wall = false
		dashed = false
		sprite.scale.x = 1
		squash_multiplier = 0.999
		sprite.play("standby")
	elif not player_controller.is_on_floor() and not player_controller.is_on_wall() and not is_on_wall and not dashed:
		sprite.play("inair")
		if abs(player_controller.velocity.y) > 0.0:
			if not sprite.scale.x < 0.85:
				sprite.scale.x *= squash_multiplier
				squash_multiplier *= 0.999
			else:
				if squash_multiplier < 1:
					squash_multiplier = 1.01
					sprite.scale.x = 1
				if not sprite.scale.x >= 1.25:
					sprite.scale.x *= squash_multiplier
					squash_multiplier *= 1.001
				
