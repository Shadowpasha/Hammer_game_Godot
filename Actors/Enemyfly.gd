extends "res://Actors/Actor.gd"

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x


func _on_Stomp_detector_body_entered(body: PhysicsBody2D) -> void:
	#get_node( "Enemysp" ).play("Dying")
	#yield(get_node( "Enemysp"),"animation_finished")
	#queue_free()
	pass




func _physics_process(delta: float) -> void:
	#velocity.y=gravity*delta
	if is_on_wall():
	 velocity.x *=-1.0
	 ChangeDirection()
	velocity.y = move_and_slide(velocity,Vector2.UP).y

var Direction = "Left"

func ChangeDirection():
	if Direction == "Left":
		get_node( "Enemysp" ).set_flip_h( false )
		Direction = "Right"
	elif Direction == "Right":
		get_node( "Enemysp" ).set_flip_h( true )
		Direction = "Left"
 
