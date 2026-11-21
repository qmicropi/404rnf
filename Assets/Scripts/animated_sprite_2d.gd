extends AnimatedSprite2D

var gracz_blisko := false
var otwarte := false

@onready var blokada: CollisionShape2D = $StaticBody2D/CollisionShape2D

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	animation_finished.connect(_on_animation_finished)

func _on_body_entered(body):
	if body.name == "gracz":
		gracz_blisko = true

func _on_body_exited(body):
	if body.name == "gracz":
		gracz_blisko = false

func _input(event):
	if event.is_action_pressed("otworz") and gracz_blisko and not otwarte:
		otwarte = true
		play("otworz")

func _on_animation_finished():
	blokada.set_deferred("disabled", true)
