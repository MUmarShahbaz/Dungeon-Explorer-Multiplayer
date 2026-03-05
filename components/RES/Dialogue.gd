extends Resource
class_name Dialogue

@export_multiline() var Text: String
@export var Sprite: Texture2D
@export var Right_Side: bool

func _init(text : String = "", sprite : Texture2D = null, right_side : bool = false) -> void:
	Text = text
	Sprite = sprite
	Right_Side = right_side
