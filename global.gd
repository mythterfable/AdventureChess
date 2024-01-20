extends Node

var square_size: int = 70
var movelist: Array
var black_move: bool

var sprites = {
	"black":{
		"bishop":preload("res://sprites/black bishop.png"),
		"king":preload("res://sprites/black king.png"),
		"knight":preload("res://sprites/black knight.png"),
		"pawn":preload("res://sprites/black pawn.png"),
		"queen":preload("res://sprites/black queen.png"),
		"rook":preload("res://sprites/black rook.png")
},
	"white":{
		"bishop":preload("res://sprites/white bishop.png"),
		"king":preload("res://sprites/white king.png"),
		"knight":preload("res://sprites/white knight.png"),
		"pawn":preload("res://sprites/white pawn.png"),
		"queen":preload("res://sprites/white queen.png"),
		"rook":preload("res://sprites/white rook.png")
}}

var square_array: Array
var piece_array: Array
var occupied_squares: Array

var square_locations: Dictionary
var pos_squares: Dictionary
var piece_positions: Dictionary
var label_squareobj: Dictionary

var new_board: Array

func xy_to_label(xy: Vector2i):
	var out: String
	var files: Dictionary = {"1" : "A", "2" : "B" , "3" : "C" , "4" : "D" , "5" : "E" , "6" : "F" , "7" : "G" , "8" : "H"}
	var file = str(xy.x)
	var rank = str(xy.y)
	out = str(files[file])+rank
	return out

func label_to_xy(label: String):
	var out: Vector2i
	var files = {"A": 1, "B": 2, "C": 3, "D": 4, "E": 5, "F": 6, "G": 7, "H": 8}
	var file = files[label[0]]
	var rank = int(label[1])
	out = Vector2i(file, rank)
	return out

func xy_to_square(xy: Vector2i):
	var label = xy_to_label(xy)
	var square = label_squareobj[label]
	return square

func get_occupied_squares():
	for square in square_array:
		for pieces in piece_array:
			if square.global_poaition == pieces.global_position:
				square.occupied = true
				if occupied_squares.has(square) == false: occupied_squares.append(square)
