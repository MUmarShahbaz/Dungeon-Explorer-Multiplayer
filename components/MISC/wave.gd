extends Node2D
class_name WaveOfMonsters

signal wave_finished

func _physics_process(delta: float) -> void:
	if get_child_count() == 0:
		wave_finished.emit()
		queue_free()
