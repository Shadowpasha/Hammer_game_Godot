extends Area2D

onready var anim_player:AnimationPlayer= $AnimationPlayer
export var next_scene: PackedScene

export var savenumber:= 0

func _on_body_entered(body: PhysicsBody2D) -> void:
	teleport()

func teleport() -> void:
	PlayerData.levelcomplete=savenumber
	yield(get_tree().create_timer(1.0), "timeout")
	anim_player.play("Fade in")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(next_scene)
	

