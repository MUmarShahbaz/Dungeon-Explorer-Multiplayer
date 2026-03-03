extends CanvasLayer
class_name Dialog

@onready var container = Control.new()
@onready var bg = ColorRect.new()
@onready var avatar_container = HBoxContainer.new()
@onready var avatar = TextureRect.new()
@onready var text_box = Label.new()

func _ready() -> void:
	add_child(container)
	container.add_child.call_deferred(bg)
	bg.add_child.call_deferred(avatar_container)
	avatar_container.add_child.call_deferred(text_box)
	avatar_container.add_child.call_deferred(avatar)
	await avatar.ready
	container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	bg.anchor_left = 0
	bg.anchor_right = 1
	bg.anchor_bottom = 1
	bg.anchor_top = 0.6
	bg.color = Color("000000a5")
	avatar_container.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	text_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_box.size_flags_vertical = Control.SIZE_FILL
	text_box.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	text_box.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	text_box.theme = load("res://assets/theme/main.tres")
	text_box.add_theme_font_size_override("font_size", 35)
	avatar.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	avatar.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED

func update_dialog(image, text ,avatar_on_right = false):
	avatar.texture = load(image)
	text_box.text = text + "\n\n(jump to continue...)"
	if avatar_on_right:
		avatar.flip_h = true
		avatar_container.alignment = BoxContainer.ALIGNMENT_END
	else:
		avatar.flip_h = false
		avatar_container.alignment = BoxContainer.ALIGNMENT_BEGIN
	
func begin_dialog(dialog_sequence : Array[Dictionary]):
	for this_dialog in dialog_sequence:
		while Input.is_action_pressed("jump"):
			await get_tree().physics_frame
		update_dialog(this_dialog[&"image"], this_dialog[&"text"], this_dialog[&"avatar_on_right"])
		while not Input.is_action_just_pressed("jump"):
			await get_tree().physics_frame
