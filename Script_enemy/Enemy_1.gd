extends KinematicBody2D

const ACCELERATION = 50
const MAX_SPEED = 100
const JUMP_H = -700
const UP = Vector2(0, -1)
const gravity = 50

var velocity = Vector2()
var direction = 1
var is_dead = false
var live = 5


func _ready():
	pass # Replace with function body.

func dead():
	live -= 1
	if live == 0:
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("Dead")
		$Timer.start()


func _physics_process(delta):
	if is_dead == false:
		velocity.x = MAX_SPEED * direction
		
		if direction == 1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		
		$AnimatedSprite.play("Walk")
		velocity.y = gravity
		velocity = move_and_slide(velocity, UP)
		
	else:
		$CollisionShape2D.disabled = true
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
func _on_Timer_timeout():
	queue_free()
