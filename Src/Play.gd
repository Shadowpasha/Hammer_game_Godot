extends Button

export(String, FILE) var scene: = ""

func _on_Play_button_up() -> void:
	get_tree().paused=false
	get_tree().change_scene(scene)
