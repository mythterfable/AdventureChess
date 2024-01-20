extends Node2D

var _board = board.new()
var pieces = preload("res://piece.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(_board)
	place_pawns(Global.new_board)
	place_rooks(Global.new_board)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func place_pawns(new_board):
	for square in new_board:
		if square.label[1] == str(2):
			var new_piece = pieces.instantiate()
			new_piece.moved.connect(_on_piece_moved)
			new_piece.position = square.position
			new_piece.type = "pawn"
			new_piece.colour = "white"
			new_piece.current_square = square.label
			new_piece.name = str(new_piece.type+square.label[0])
			square.occupied = true
			Global.occupied_squares.append(square)
			square.guest = new_piece
			add_child(new_piece)
		elif square.label[1] == str(7):
			var new_piece = pieces.instantiate()
			new_piece.moved.connect(_on_piece_moved)
			new_piece.position = square.position
			new_piece.type = "pawn"
			new_piece.colour = "black"
			new_piece.current_square = square.label
			square.occupied = true
			Global.occupied_squares.append(square)
			square.guest = new_piece
			add_child(new_piece)

func place_rooks(new_board):
	for square in new_board:
		if square.label in ["A1", "H1"]:
			var new_piece = pieces.instantiate()
			new_piece.moved.connect(_on_piece_moved)
			new_piece.position = square.position
			new_piece.type = "rook"
			new_piece.colour = "white"
			new_piece.current_square = square.label
			new_piece.name = str(new_piece.type+square.label[0])
			square.occupied = true
			Global.occupied_squares.append(square)
			square.guest = new_piece
			add_child(new_piece)
	for square in Global.square_array:
		if square.label in ["A8", "H8"]:
			var new_piece = pieces.instantiate()
			new_piece.moved.connect(_on_piece_moved)
			new_piece.position = square.position
			new_piece.type = "rook"
			new_piece.colour = "black"
			new_piece.current_square = square.label
			new_piece.name = str(new_piece.type+square.label[0])
			square.occupied = true
			square.guest = new_piece
			add_child(new_piece)

func _on_piece_moved(ID, start_square, new_square, capture):
	if capture:
		print(start_square.label,"X",new_square.label)
	else:
		print(start_square.label," : ",new_square.label)
	if Global.black_move: Global.black_move == false
	else: Global.black_move == true
