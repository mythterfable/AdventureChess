extends Node2D
class_name piece
signal moved (ID: Object, old_square: String, new_square: String)
signal capture (target: Object)

var colour: String = "white"
var type: String = "pawn"
var current_square: String

var texture: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = Global.sprites[colour][type]
	current_square = Global.pos_squares[global_position].label
	Global.label_squareobj[current_square].occupied = true
	Global.label_squareobj[current_square].guest = self

func _on_sprite_moved(ID, start_square, new_square, capture):
	emit_signal("moved", ID, start_square, new_square, capture)
	current_square = new_square.label
	if capture == false:
		Global.occupied_squares.append(new_square)
		Global.occupied_squares.erase(start_square)

