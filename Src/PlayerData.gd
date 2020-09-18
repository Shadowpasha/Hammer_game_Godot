extends Node

var score := 0
var death:=0 setget set_death
var levelcomplete:= 0 setget set_level
var smashing:=false setget smash
signal smashing 
signal Player_died 
signal levelcompleted
const filepath :="user://savegame.data"
var file=File.new()
func _ready() -> void:
	if file.file_exists(filepath) :
		file.open(filepath,File.READ)
		levelcomplete=file.get_var()
		file.close()

func set_death(value: int) -> void:
	
	death=value
	emit_signal("Player_died")
	
func set_level(value: int) -> void:
	if(levelcomplete < value):
		levelcomplete=value
	file.open(filepath,File.WRITE)
	file.store_var(levelcomplete)
	file.close()
	emit_signal("levelcompleted")
	
func smash(value: bool) -> void:
	smashing=value
	emit_signal("smashing")
	
