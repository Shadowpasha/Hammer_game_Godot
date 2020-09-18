extends Actor


signal player_died

var issmashing:=false

var isend:=false

func _physics_process(delta: float) -> void:
	var direction:= get_direction()
	velocity = calcaulate_move_velocity(velocity,direction,speed,anim_player_p)
	velocity = move_and_slide(velocity,Vector2.UP)
	if is_on_floor()==false and issmashing==false and isend==false:
		anim_player_p.play("in_air")
	if Input.is_action_just_pressed("smash") and is_on_floor()==false:
		issmashing=true
		PlayerData.smashing=true
		gravity=3000
		anim_player_p.play("Defualt")
		get_node("Character").play("Smash")
	
	
export var stomp: = 1000.0
onready var anim_player_p: AnimationPlayer = get_node("Animator")
onready var sprite:AnimatedSprite=get_node("Character")

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	if(issmashing):
		issmashing=false
		gravity=1500
		anim_player_p.play("in_air")
		sprite.play("idle")
		velocity = calculate_stomp_velocity(velocity,stomp)
		var enemy := area.get_parent()
		enemy.get_node( "AnimationPlayer" ).play("dying")
		yield(enemy.get_node( "AnimationPlayer"),"animation_finished")
		enemy.queue_free()
	else:
		self.set_physics_process(false)
		get_node("CollisionShape2D").set_deferred("disabled",true)
		sprite.play("death")
		anim_player_p.play("Death")
		yield(get_tree().create_timer(1.5),"timeout")
		PlayerData.death=1
		self.visible=false

func _on_EnemyDetector_body_entered(area: Area2D) -> void:
	self.set_physics_process(false)
	get_node("CollisionShape2D").set_deferred("disabled",true)
	sprite.play("death")
	anim_player_p.play("Death")
	yield(get_tree().create_timer(1.5),"timeout")
	PlayerData.death=1
	self.visible=false

func calculate_stomp_velocity(velocity:Vector2, stomp:float) -> Vector2:
	var bounce=velocity
	bounce.y=-stomp
	return bounce

func get_direction() -> Vector2:
	return Vector2(
Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
0.0
)

func _ready() -> void:
	PlayerData.connect("levelcompleted",self,"_onlevelcomplete")

func calcaulate_move_velocity(
linear_velocity: Vector2,
speed: Vector2,
direction: Vector2,
anim_player: AnimationPlayer
) -> Vector2:
	var out = linear_velocity
	out.x= speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time() 
	
	 
	
	return out
func _onlevelcomplete() -> void:
	isend=true
	anim_player_p.play("End")
	

func _on_Ground_body_entered(body: PhysicsBody2D) -> void:
	self.set_physics_process(false)
	sprite.play("death")
	anim_player_p.play("Death")
	yield(get_tree().create_timer(1.5),"timeout")
	get_node("CollisionShape2D").set_deferred("disabled",true)
	PlayerData.death=1
	self.visible=false
	
