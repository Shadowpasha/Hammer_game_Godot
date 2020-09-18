extends Button




func _on_RETRY_button_up() -> void:
	get_tree().paused=false
	get_tree().reload_current_scene()
