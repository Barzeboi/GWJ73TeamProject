extends Node2D
class_name Tetromino

var is_random := false
var default_blocks : Dictionary

var origin: Marker2D
var rotation_point: Marker2D

func _init(p_is_random = false):
	is_random = p_is_random
	
func initialize():
	# Initialize the default block for each type of tetromino
	pass

func align_center_to(p_target: Vector2):
	self.translate(p_target)

func _ready():
	initialize()
	var points = $Markers.get_children() as Array[Marker2D]
	var block_scene = preload("res://_second/scenes/block.tscn")
	for point in points:
		var block = block_scene.instantiate()
		block.type = BlockType.ALL.pick_random() if is_random else default_blocks.get(point, BlockType.NEUTRAL)
		block.position = point.position
		add_child(block)
