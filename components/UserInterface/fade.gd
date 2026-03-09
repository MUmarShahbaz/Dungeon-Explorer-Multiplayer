extends CanvasLayer
class_name Fade

@onready var rect = ColorRect.new()

@export var color : Color
@export var duration : float
@export var start_blank: bool

enum fade_type {fade_in, fade_out}
var type : fade_type
var fading: bool = false

func _ready() -> void:
	rect.color = color
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	if start_blank:
		rect.color.a = 0
		hide()
	add_child(rect)

func _process(delta: float) -> void:
	if fading:
		if type == fade_type.fade_in:
			rect.color.a -= (duration * delta)
			if rect.color.a <= 0: fading = false
		if type == fade_type.fade_out:
			rect.color.a += (duration * delta)
			if rect.color.a >= 1: fading = false

func fade_in():
	type = fade_type.fade_in
	fading = true
	while clamp(rect.color.a, 0, 1) != 0:
		await get_tree().physics_frame
	hide()
	return

func fade_out():
	show()
	type = fade_type.fade_out
	fading = true
	while clamp(rect.color.a, 0, 1) != 1:
		await get_tree().physics_frame
	return
