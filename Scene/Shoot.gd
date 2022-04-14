extends Area2D

var velocity = Vector2.ZERO
var speed = 3

func _ready():
	pass 

func _physics_process(delta):
	position.x += velocity.x*speed*delta
	position.y += velocity.y*speed*delta
	pass
	
func InitDirection(Pvelocity:Vector2 ):
	velocity = Vector2(Pvelocity.x * speed, Pvelocity.y * speed)
	pass

