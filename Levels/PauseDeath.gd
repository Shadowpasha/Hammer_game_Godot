extends Control

onready var scene_tree:= get_tree()
onready var pauseoverlay:= get_node(".")
onready var title:= get_node("Label")
onready var paused := false setget set_paused
var loss := ["Hammer Bumper","Didn't Nail This","Game Over","Looks Like You're Hammered",]
func _ready() -> void:
	PlayerData.connect("Player_died",self,"show_death")
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		
		scene_tree.set_input_as_handled()
	
func set_paused(value: bool)->void:

	paused = value
	scene_tree.paused=paused
	pauseoverlay.visible=value
	
func show_death() -> void:
	if pauseoverlay.visible==false:
		var x:= rand_range(0,4)
		pauseoverlay.visible=true
		title.text=loss[x]
	
