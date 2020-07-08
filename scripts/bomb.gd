extends RigidBody2D

onready var sprite = $sprite
onready var collision = $collision
onready var anim = $anim

signal bomb

var cutted = false

func _ready():
	randomize()

func _process(delta):
	if position.y > 800:
		queue_free()

func born(pos : Vector2):
	position = pos
	var vel = Vector2(0, rand_range(-1100, -900))
	if pos.x < 640:
		vel = vel.rotated(deg2rad(rand_range(0, 25)))
	else:
		vel = vel.rotated(deg2rad(rand_range(0, -25)))
	linear_velocity = vel
	angular_velocity = rand_range(-15, 15)

func cut():
	if cutted: return
	cutted = true
	emit_signal("bomb")
	mode = MODE_KINEMATIC
	anim.play("explode")

