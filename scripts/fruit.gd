extends RigidBody2D

onready var collision = $collision
onready var sprite_main = $sprite
onready var half_left = $half_left
onready var half_right = $half_right
onready var half_left_sprite = $half_left/sprite
onready var half_right_sprite = $half_right/sprite

var cutted = false

signal score
signal mistake

func _ready():
	randomize()
	#born(Vector2(640, 800))

func _process(delta):
	if position.y > 800:
		emit_signal("mistake")
		queue_free()
	if half_left.position.y > 800 and half_right.position.y > 800:
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
	emit_signal("score")
	mode = MODE_KINEMATIC
	sprite_main.queue_free()
	collision.queue_free()
	half_left.mode = MODE_RIGID
	half_right.mode = MODE_RIGID
	half_left.apply_impulse(Vector2(0, 0), Vector2(-130, 0).rotated(rotation))
	half_right.apply_impulse(Vector2(0, 0), Vector2(130, 0).rotated(rotation))
	half_left.angular_velocity = angular_velocity
	half_right.angular_velocity = angular_velocity

func _on_Timer_timeout():
	cut()
	pass
