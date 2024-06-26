extends Node2D


@export var y_end = 500
@export var end_index = 10 

var moyenne = y_end * 0.5
@export var speed = 6
var list = []
var index = 0
var run = false
@onready var sprite = $Sprite2D
var win_image = null

var preloaded_ressources = []

signal finished
signal pass_


func _ready():
	GAME.connect("start_game", _start)
	sprite.position.y = 0
	$AnimationPlayer.play("stop")
	preload_ressources()

func preload_ressources():
	preloaded_ressources.append(load("res://assets/baloon.png"))
	preloaded_ressources.append(load("res://assets/Cherry.png"))
	preloaded_ressources.append(load("res://assets/forest.png"))
	preloaded_ressources.append(load("res://assets/UwU.png"))
	preloaded_ressources.append(load("res://assets/Money.png"))

func _gen_list():
	list = []
	for __ in range(end_index):
		var num = randi_range(0, 4)
		list.append(num)
		
	
func _process(_delta):
	if run :
		if index == end_index -1 :
			run = false
			$AnimationPlayer.play("stop")
		else:
			$AnimationPlayer.play("slide")

func update_image():
	sprite.set_texture(get_image())
	sprite.set_global_scale(Vector2(0.15,0.15))
	
func get_image(num = false):
	var ret = "book"
	
	if !num:
		ret = preloaded_ressources[list[index]]
	return ret

func _start():
	speed = 6
	$AnimationPlayer.set_speed_scale(speed)
	index = 0
	_gen_list()
	run = true


func _on_animation_player_animation_finished(anim_name):
	emit_signal("pass_")
	if anim_name == "stop" and index != 0:
		emit_signal("finished")
	if run :
		index += 1 
		speed -= 0.5
		$AnimationPlayer.set_speed_scale(speed)
		update_image()
		if index == end_index -1:
			win_image = list[index]
			

	
