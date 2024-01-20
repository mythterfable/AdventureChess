extends Node2D
class_name board

var square = preload("res://square.tscn")
var pieces = preload("res://piece.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.new_board = generate_board()
	reposition_board(Global.new_board, 50)
	for square in Global.new_board:
		Global.square_locations[square.label] = square.position
		Global.pos_squares[square.position] = square
		Global.square_array.append(square)

func generate_board():
	var squares_array: Array
	for row in range(8):
		for col in range(8):
			# Instantiate the scene
			var new_square = square.instantiate()
			new_square.broadcast.connect(_on_broadcast)
			# Set the label
			new_square.label = str(char(65 + col)) + str(8 - row)
			new_square.xy.x = col+1
			new_square.xy.y = 8-row
			Global.label_squareobj[new_square.label] = new_square
			new_square.name = str(new_square.label)
			# Set the light boolean
			if (row + col) % 2 == 0:
				new_square.light = true
			else:
				new_square.light = false
			# Set the position
			new_square.position = Vector2i(col * Global.square_size, row * Global.square_size)
		# Add the instance to the scene
			add_child(new_square)
			squares_array.append(new_square)
	return squares_array

func _on_broadcast(ID, square, occupied):
	pass

func reposition_board(new_board: Array, offset: int):
	for each in new_board:
		each.position.x += offset
		each.position.y += offset*1.5

