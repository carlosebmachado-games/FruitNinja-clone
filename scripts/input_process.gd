extends Node2D

onready var limit = $limit
onready var interval = $interval

var pressed = false
var dragging = false
var cur_pos = Vector2.ZERO
var old_pos = Vector2.ZERO

func _physics_process(delta):
	update()
	if dragging and cur_pos != old_pos and old_pos != Vector2.ZERO:
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray(old_pos, cur_pos)
		if not result.empty():
			result.collider.cut()

func _input(event):
	event = make_input_local(event)
	if event is InputEventScreenTouch:
		if event.is_pressed():
			press(event.position)
		else:
			release()
	elif event is InputEventScreenDrag:
		drag(event.position)

func press(pos : Vector2):
	pressed = true
	old_pos = pos
	limit.start()
	interval.start()

func release():
	pressed = false
	dragging = false
	limit.stop()
	interval.stop()
	old_pos = Vector2.ZERO
	cur_pos = Vector2.ZERO

func drag(pos : Vector2):
	cur_pos = pos
	dragging = true

func _on_interval_timeout():
	old_pos = cur_pos

func _on_limit_timeout():
	release()

func _draw():
	if dragging and cur_pos != old_pos and old_pos != Vector2.ZERO:
		draw_line(cur_pos, old_pos, Color(1, 0, 0), 10)
