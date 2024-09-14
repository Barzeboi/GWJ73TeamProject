extends TileMapLayer

#Tetrominoes
#i = Line Piece
var l_0 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(3, 1)]
var l_90 := [Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 2), Vector2i(2, 3)]
var l_180 := [Vector2i(0, 2), Vector2i(1, 2), Vector2i(2, 2), Vector2i(3, 2)]
var l_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(1, 3)]
var l := [l_0, l_90, l_180, l_270]
#t = Wedge Piece
var t_0 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var t_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var t_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var t := [t_0, t_90, t_180, t_270]
#o = Square Piece
var o_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_90 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_180 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)]
var o := [o_0, o_90, o_180, o_270]
#z = Dog Piece
var z_0 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)]
var z_90 := [Vector2i(2, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(1, 2)]
var z_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var z_270 := [Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(0, 2)]
var z := [z_0, z_90, z_180, z_270]
#s = Reverse Dog Piece
var s_0 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1)]
var s_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var s_180 := [Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2), Vector2i(1, 2)]
var s_270 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)]
var s := [s_0, s_90, s_180, s_270]
#i = "L" piece
var i_0 := [Vector2i(2, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var i_90 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(2, 2)]
var i_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(0, 2)]
var i_270 := [Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2)]
var i := [i_0, i_90, i_180, i_270]
#j = reverse "L" piece
var j_0 := [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1)]
var j_90 := [Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1), Vector2i(1, 2)]
var j_180 := [Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1), Vector2i(2, 2)]
var j_270 := [Vector2i(1, 0), Vector2i(1, 1), Vector2i(0, 2), Vector2i(1, 2)]
var j := [j_0, j_90, j_180, j_270]

var shapes := [l, t, o, z, s, i, j]
var shapes_full := shapes.duplicate()

#Grid Variables
const COL: int = 12
const ROWS: int = 20

#Movement Variables
const directions := [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.DOWN]
var steps : Array
const steps_req : int = 50
const start_pos := Vector2i(8,1)
var  cur_pos : Vector2i
var speed : float
#Game Piece Variables
var piece_type
var next_piece_type
var rotation_index : int = 0
var active_piece : Array

#TileMap Variables
var tile_id: int = 0
var piece_atlas : Vector2i
var next_piece_atlas : Vector2i

func _ready() -> void:
	_new_game()
	
	
func _new_game():
	#resets variables
	speed = 1.0
	steps = [0,0,0]
	piece_type = _pick_piece()
	piece_atlas = Vector2i(shapes_full.find(piece_type), 0)
	_create_piece()

func _process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		steps[0] += 10
	if Input.is_action_pressed("Right"):
		steps[1] += 10
	if Input.is_action_pressed("Down"):
		steps[2] += 10
	#apply downward movement every frame
	steps[2] += speed
	if steps[2] > steps_req:
		_move_pieces(Vector2i.DOWN)
		steps[2] = 0

#Chooses what type of piece ot draw, it also randomizes though shuffling the shapes array and removing a piece once it has been called
func _pick_piece():
	var piece
	if not shapes.is_empty():
		shapes.shuffle()
		piece = shapes.pop_front()
	else:
		shapes = shapes_full.duplicate()
		shapes.shuffle()
		piece = shapes.pop_front()
	return piece
	
func _create_piece():
	#resets variables
	cur_pos = start_pos
	active_piece = piece_type[rotation_index]
	_draw_piece(active_piece, cur_pos, piece_atlas)

func _clear_piece():
	for f in active_piece:
		erase_cell(cur_pos + f)
func _draw_piece(piece, pos, atlas):
	for f in piece:
		set_cell(pos + f, tile_id, atlas)
		
func _move_pieces(dir):
	_clear_piece()
	cur_pos += dir
	_draw_piece(active_piece, cur_pos, piece_atlas)
