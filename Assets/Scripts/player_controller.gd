extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 20.0
@export var acceleration = 2500.0 
@export var friction = 1000.0      


@export var dash_speed = 450.0     
@export var dash_duration = 0.15   
@export var dash_cooldown = 1   

@export var teleportto : Area2D

var dash_timer = 0.0
var cooldown_timer = 0.0
var dashed = false
var dashd = 0


var speed_multiplier = 30.0
var jump_multiplier = -15.0
var direction = 0
var on_wall = false
var wall_used = false
var wall_jumped = false
var cjcd = 0.0


func _physics_process(delta: float) -> void:
	# 1. Update timers
	if dash_timer > 0:
		dash_timer -= delta
		move_and_slide()
		return
		
	if cooldown_timer > 0:
		cooldown_timer -= delta
		
	if cjcd > 0:
		cjcd -= delta

	direction = Input.get_axis("move_left", "move_right")

	# 2. Trigger Dash
	if Input.is_action_just_pressed("dash") and cooldown_timer <= 0:
		var dash_dir = direction if direction != 0 else (1.0 if not direction else -1.0) 
		if direction == 0:
			dash_dir = 1.0 
			
		dash_timer = dash_duration
		cooldown_timer = dash_cooldown
		if Input.is_action_pressed("move_left"):
			velocity.x = -1 * dash_speed if direction != 0 else dash_speed 
			if Input.is_action_pressed("jump"):
				velocity.y = -1 * dash_speed if direction != 0 else dash_speed
				dashd = 2
			if Input.is_action_pressed("down"):
				velocity.y = 1 * dash_speed if direction != 0 else dash_speed
				dashd = 3
			dashd = 1
		elif Input.is_action_pressed("move_right"):
			velocity.x = 1 * dash_speed if direction != 0 else dash_speed 
			if Input.is_action_pressed("jump"):
				velocity.y = -1 * dash_speed if direction != 0 else dash_speed
				dashd = 5
			if Input.is_action_pressed("down"):
				velocity.y = 1 * dash_speed if direction != 0 else dash_speed
				dashd = 6
			dashd = 4
		
		return
	
	if is_on_floor():
		cjcd = 0.15
	

	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("jump") and cjcd > 0:
		velocity.y = jump_power * jump_multiplier
		
	
	
	if Input.is_action_pressed("hold") and not is_on_floor() and is_on_wall():
		on_wall = true
		wall_used = true
		if Input.is_action_just_pressed("jump"):
			wall_jumped = true
			velocity.y = -1200
		elif Input.is_action_pressed("down"):
			velocity.y = 50
		else:
			velocity.y = 0
	else:
		if wall_used and Input.is_action_pressed("jump"):
			velocity.y = -250
		on_wall = false
		wall_used = false


	if direction != 0:
		var target_speed = direction * speed * speed_multiplier
		velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()








func _on_teleportback_body_entered(body: Node2D) -> void:
	print('ah')

@export var ramlabel : Label
@export var showlab : Label

var ramstick_count = 0

var ramstick1 = false
var ramstick2 = false
var ramstick3 = false
var ramstick4 = false
var ramstick5 = false
var ramstick6 = false

func _on_ramstick_1_body_entered(body: Node2D) -> void:
	if not ramstick1:
		ramstick_count += 1
		ramstick1 = true
		
		ramlabel.text = str(ramstick_count) + "/6"
	
func _on_ramstick_2_body_entered(body: Node2D) -> void:
	if not ramstick2:
		ramstick_count += 1
		ramstick2 = true
		
		ramlabel.text = str(ramstick_count) + "/6"
	
func _on_ramstick_3_body_entered(body: Node2D) -> void:
	if not ramstick3:
		ramstick_count += 1
		ramstick3 = true
		
		ramlabel.text = str(ramstick_count) + "/6"
	
func _on_ramstick_4_body_entered(body: Node2D) -> void:
	if not ramstick4:
		ramstick_count += 1
		ramstick4 = true
		
		ramlabel.text = str(ramstick_count) + "/6"
	
func _on_ramstick_5_body_entered(body: Node2D) -> void:
	if not ramstick5:
		ramstick_count += 1
		ramstick5 = true
		
		ramlabel.text = str(ramstick_count) + "/6"

func _on_ramstick_6_body_entered(body: Node2D) -> void:
	if not ramstick6:
		ramstick_count += 1
		ramstick6 = true
		
		ramlabel.text = str(ramstick_count) + "/6"
		

@export var win : Control
@export var lose : Control
var winned = false




func _on_win_body_entered(body: Node2D) -> void:
	if ramstick_count >= 6:
		win.visible = true
		winned = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if ramstick_count >= 1 and not winned:
		lose.visible=true # Replace with function body.
