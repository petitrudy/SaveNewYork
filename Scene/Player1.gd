extends KinematicBody2D

const MAX_SPEED = 50
const ACCELERATION = 500
var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
var x = 0.0
var y = 0.0	
var animation = "Idle"
var plShoot := preload("res://Scene/Shoot.tscn")
var shootTimer = 0
# Called when the node enters the scene tree for the first time.

var animationPlayer = null

#onready var peut être utilisé
func _ready():
	animationPlayer = $AnimationPlayer
	
func _physics_process(delta):
	
	
	PlayerControl(delta)
	
	if (Input.is_action_just_pressed("ui_space") && shootTimer<=0 && velocity != Vector2.ZERO):
		#Shoot
		#rint("Create Bullet")
		var shoot := plShoot.instance()
		shoot.position = position
		shoot.InitDirection(velocity, animation)
		
		shootTimer = 40		
		get_tree().current_scene.add_child(shoot)
		
	if shootTimer>0:
		shootTimer-=1
				
func PlayerControl(delta):

	if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_up"):
		x = 1
		y = -1
		animation = "MoveUpRight"
	elif Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_down"):
		x = 1
		y = 1
		animation = "MoveDownRight"
	elif Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_up"):
		x = -1
		y = -1
		animation = "MoveUpLeft"
	elif Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_down"):
		x = -1
		y = 1
		animation = "MoveDownLeft"
	elif Input.is_action_pressed("ui_right"):
		x = 1
		y = 0
		animation = "MoveRight"
	elif Input.is_action_pressed("ui_left"):
		x = -1
		y = 0
		animation = "MoveLeft"
	elif Input.is_action_pressed("ui_up"):
		y = -1
		x = 0
		animation = "MoveUp"
	elif Input.is_action_pressed("ui_down"):
		y = 1
		x = 0
		animation = "MoveDown"
		
	animationPlayer.play(animation)
	input_vector = Vector2(x,y)
	input_vector.normalized()
	
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	
	velocity = move_and_slide(velocity)
	
	if position.x <= 0:
		position.x = 0
	elif position.x >= 304:
		position.x = 304
	if position.y <= 0:
		position.y = 0
	elif position.y >= 184:
		position.y = 184
		
