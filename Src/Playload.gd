extends Button

var scene: = ["res://Levels/LevelTest.tscn","res://Levels/Level2.tscn","res://Levels/Level3.tscn","res://Levels/Level4.tscn","res://Levels/Level5.tscn","res://Levels/Level6.tscn"]

func _on_play_Scene_button_up() -> void:
	get_tree().paused=false
	if(PlayerData.levelcomplete < scene.size()):
		get_tree().change_scene(scene[PlayerData.levelcomplete])
	else:
		get_tree().change_scene(scene[scene.size()-1])
