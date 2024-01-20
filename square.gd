extends Node2D
class_name squares
signal broadcast(ID: Object, label: String, occupied: bool)

@export var light: bool
var label: String
var occupied: bool
var guest: Object
var xy: Vector2i

func _ready():
	$Sprite2D.scale = Vector2i(70,70)
	if light: $Sprite2D.self_modulate = Color(0.98, 0.647, 0.455)
	else: $Sprite2D.self_modulate = Color(0.321, 0.175, 0.029)
	var Label = Label.new()
	Label.text = label
	if light: Label.self_modulate.a = 0.9
	else: Label.self_modulate.a = 0.5
	Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	Label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	Label.position.x += 10
	Label.position.y += 10
	add_child(Label)
	emit_signal("broadcast", self, label, null)
