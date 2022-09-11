extends KinematicBody2D

const ACCELERATION = 70
const MAX_SPEED = 200 
const RUN_ACELERATION = 200
const RUN_MAX_SPEED = 500
const JUMP_H = -700
const UP = Vector2(0, -1)
const gravity = 40

var JUMP = false
var RUN = false
var motion = Vector2()
var velocity=Vector2()
var friction = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
		
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		if JUMP == false:
			if Input.is_action_pressed("Run"):
				if  RUN == false: 
					$AnimatedSprite.flip_h=false
					$AnimatedSprite.play("Run")
					motion.x = min(motion.x + RUN_ACELERATION, RUN_MAX_SPEED)
			else:
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("Walk")
				motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		
	elif Input.is_action_pressed("ui_left"):
		if JUMP == false: 
			if Input.is_action_pressed("Run"):
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("Run")
				motion.x = max(motion.x - RUN_ACELERATION, -RUN_MAX_SPEED)
			else:
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("Walk")
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		
	else:
		if JUMP == false:
			$AnimatedSprite.play("Idle")
			friction = true
	
	if is_on_floor():
 
		if Input.is_action_just_pressed("ui_up") :
			$AnimatedSprite.play("Jump")
			motion.y = JUMP_H
			JUMP = true
			RUN = true
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		RUN = true
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)
 
	motion = move_and_slide(motion, UP)


func _on_AnimatedSprite_animation_finished():
	JUMP = false
	RUN = false 
