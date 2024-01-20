extends Sprite2D
signal moved (ID: Object, old_square: String, new_square: String, capture: bool)

var dragging: bool
var drag_offset
var start_square
var turn: bool
var colour
var captured: bool

func _ready():
	colour = $"..".colour

func check_turn(colour, black_move):
	if colour == "black":
		if black_move:
			return true
		elif black_move == false:
			return false
	if colour == "white":
		if black_move:
			return false
		elif black_move == false:
			return true

func check_move(moved_piece, start_square, end_square):
	if $"..".type == "pawn":
		if pawn_move(moved_piece, start_square, end_square):
			return true
	if $"..".type == "rook":
		if rook_move(moved_piece, start_square, end_square):
			return true
	else: return false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and check_turn(colour, Global.black_move):
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				dragging = true
				start_square = Global.label_squareobj[$"..".current_square]
				drag_offset = self.position - get_viewport().get_mouse_position()
		elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and dragging == true:
				dragging = false
				var min_distance = 1000000
				var nearest_square = null
				for square in Global.new_board:
					var distance = (Global.square_locations[square.label] - get_viewport().get_mouse_position()).length()
					if distance < min_distance:
						min_distance = distance
						nearest_square = square
					self.global_position = nearest_square.global_position
				if check_move($"..", start_square, nearest_square):
					if nearest_square.occupied:
						if nearest_square.guest.colour != $"..".colour:
							captured = true
							nearest_square.guest.free()
					else: captured = false
					nearest_square.guest = $".."
					start_square.occupied = false
					nearest_square.occupied = true
					emit_signal("moved", self, start_square, nearest_square, captured)
					Global.movelist.append(str(start_square.label+" to "+nearest_square.label))
					if Global.black_move: Global.black_move = false
					else: Global.black_move = true
				else: self.global_position = start_square.position
	if event is InputEventMouseMotion:
		if dragging:
			self.position = get_viewport().get_mouse_position() + drag_offset

func pawn_move(object, start_square, new_square):
	var start_xy = start_square.xy
	var new_xy = new_square.xy
	if object.colour == "white":
		if start_xy.y == 2:
			if new_xy.y == 3 or new_xy.y == 4:
				if new_xy.x == start_xy.x:
					return true
		else:
			if new_xy.y == start_xy.y+1:
				if new_xy.x == start_xy.x:
					return true
				if new_xy.x != start_xy.x:
					if new_xy.x == start_xy.x+1 or new_xy.x == start_xy.x-1:
						if new_xy.y == start_xy.y+1:
							if new_square.occupied:	
								return true
			else:
				return false
	else:
		if start_xy.y == 7:
			if new_xy.y == 6 or new_xy.y == 5:
				if new_xy.x == start_xy.x:
					return true
		else:
			if new_xy.y == start_xy.y-1:
				if new_xy.x == start_xy.x:
					return true
				if new_xy.x != start_xy.x:
					if new_xy.x == start_xy.x+1 or new_xy.x == start_xy.x-1:
						if new_xy.y == start_xy.y-1:
							if new_square.occupied:
								return true
			else:
				return false

func rook_move(object: Object, start_square: squares, new_square: squares):
	var start_xy = Global.label_to_xy(start_square.label)
	var new_xy = Global.label_to_xy(new_square.label)
	if new_xy.x != start_xy.x and new_xy.y != start_xy.y:
		return false
	if new_xy.y == start_xy.y:
		if new_xy.x > start_xy.x:
			for i in range(start_xy.x + 1, new_xy.x, 1):
				var square = Global.xy_to_square(Vector2i(i, start_xy.y))
				if square.occupied:
					if square.guest.colour != colour:
						return true
				else:
					return true
					
		else:
			for i in range(new_xy.x - 1, start_xy.x, -1):
				var square = Global.xy_to_square(Vector2i(i, start_xy.y))
				if square.occupied:
					if square.guest.colour == colour:
						return false
					else: 
						return true
				else: return true
			return true
	elif new_xy.x == start_xy.x:
		if new_xy.y > start_xy.y:
			for i in range(start_xy.y + 1, new_xy.y, 1):
				var square = Global.xy_to_square(Vector2i(start_xy.x, i))
				if square.occupied:
					if square.guest.colour != colour:
						return true
					else: 
						return false
		else:
			for i in range(new_xy.y - 1, start_xy.y, -1):
				var square = Global.xy_to_square(Vector2i(start_xy.x, i))
				if square.occupied:
					if square.guest.colour == colour:
						return false
					else: 
						return true
			return true
	else:
		return false

