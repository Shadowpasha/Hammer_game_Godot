extends TextureRect

var x := PlayerData.levelcomplete


func _ready() -> void:
	while x>=0 :
		var node := get_tree().get_root().get_node("Mainscreen/" + String(x))
		node.visible=true
		x=x-1
	

