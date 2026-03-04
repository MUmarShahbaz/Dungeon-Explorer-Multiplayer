extends Node
class_name Dialogue

@export var Text: String
@export var Sprite: Resource
@export var Right_Side: bool

func _init(text : String, sprite : Resource, right_side : bool) -> void:
	Text = text
	Sprite = sprite
	Right_Side = right_side
