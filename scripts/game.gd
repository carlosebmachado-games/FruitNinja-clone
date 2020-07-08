extends Node2D

var avocado = preload("res://scenes/avocado.tscn")
var banana = preload("res://scenes/banana.tscn")
var lemon = preload("res://scenes/lemon.tscn")
var orange = preload("res://scenes/orange.tscn")
var pear = preload("res://scenes/pear.tscn")
var pineapple = preload("res://scenes/pineapple.tscn")
var tomato = preload("res://scenes/tomato.tscn")
var watermelon = preload("res://scenes/watermelon.tscn")
var bomb = preload("res://scenes/bomb.tscn")

onready var fruits = $fruits
onready var input_process = $input_process

onready var lbl_score = $ui/lbl_score
onready var x0 = $ui/x0
onready var x1 = $ui/x1
onready var x2 = $ui/x2

var score = 0
var mistakes = 0

func _on_generator_timeout():
	if mistakes >= 3: return
	for i in range(0, rand_range(1, 6)):
		var type = int(rand_range(0, 9))
		var fruit
		match type:
			0:
				fruit = avocado.instance()
			1:
				fruit = banana.instance()
			2:
				fruit = lemon.instance()
			3:
				fruit = orange.instance()
			4:
				fruit = pear.instance()
			5:
				fruit = pineapple.instance()
			6:
				fruit = tomato.instance()
			7:
				fruit = watermelon.instance()
			8:
				fruit = bomb.instance()
		
		fruit.born(Vector2(rand_range(200, 1080), 800))
		
		if fruit.name == "bomb":
			fruit.connect("bomb", self, "bomb_explode")
		else:
			fruit.connect("mistake", self, "increase_mistake")
			fruit.connect("score", self, "increase_score")
		
		fruits.add_child(fruit)

func bomb_explode():
		$game_over.start()
		mistakes = 3

func increase_mistake():
	mistakes += 1
	if mistakes == 3:
		x2.show()
		input_process.end_game = true
		$game_over.start()
	if mistakes == 1:
		x0.show()
	if mistakes == 2:
		x1.show()

func increase_score():
	if mistakes == 3: return
	score += 1
	lbl_score.text = str(score)
