extends Node2D

var z_tetrominos_scene = preload("res://_second/scenes/z_tetrominos.tscn")

var active_tetromino: Tetromino
var move_interval := 1.0
var time = 0

func _ready():
	snap_spawn()
	create_tetrominos()

func _process(delta):
	var should_move = false
	time += delta
	if time >= move_interval:
		should_move = true
		time = 0
		
	if active_tetromino and should_move:
		active_tetromino.translate(Vector2.DOWN * 32)

func snap_spawn():
	var position_with_offset = $SpawnPoint.global_position
	var rounded_position = Vector2i(position_with_offset / 32) * 32 + Vector2i(16, 16)
	$SpawnPoint.global_position = rounded_position as Vector2

func create_tetrominos():
	var entity : ZTetromino = z_tetrominos_scene.instantiate()
	add_child(entity)
	entity.align_center_to($SpawnPoint.global_position)
	active_tetromino = entity
