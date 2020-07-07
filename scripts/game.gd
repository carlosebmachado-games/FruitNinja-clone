extends Node2D

onready var fruits = $fruits

var avocado = preload("res://scenes/avocado.tscn")
var banana = preload("res://scenes/banana.tscn")
var lemon = preload("res://scenes/lemon.tscn")
var orange = preload("res://scenes/orange.tscn")
var pear = preload("res://scenes/pear.tscn")
var pineapple = preload("res://scenes/pineapple.tscn")
var tomato = preload("res://scenes/tomato.tscn")
var watermelon = preload("res://scenes/watermelon.tscn")

func _on_generator_timeout():
	for i in range(0, rand_range(1, 5)):
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
				fruit = watermelon.instance() # bomb
		
		fruit.born(Vector2(rand_range(200, 1080), 800))
		fruits.add_child(fruit)
