extends KinematicBody2D

const ROCK=preload("res://Rock.tscn")
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
var is_attacking = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
		
	motion.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		if JUMP == false and is_attacking == false:
			if Input.is_action_pressed("Run"):
				if  RUN == false : 
					$AnimatedSprite.flip_h=false
					$AnimatedSprite.play("Run")
					motion.x = min(motion.x + RUN_ACELERATION, RUN_MAX_SPEED)
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
			else:
				$AnimatedSprite.flip_h=false
				$AnimatedSprite.play("Walk")
				motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
		
	elif Input.is_action_pressed("ui_left"):
		if JUMP == false and is_attacking == false: 
			if Input.is_action_pressed("Run"):
				$AnimatedSprite.flip_h=true
				$AnimatedSprite.play("Run")
				motion.x = max(motion.x - RUN_ACELERATION, -RUN_MAX_SPEED)
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
			else:
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("Walk")
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
		
	else:
		if JUMP == false and is_attacking == false:
			$AnimatedSprite.play("Idle")
			friction = true
	
	if Input.is_action_just_pressed("Attack_1") and is_attacking == false:
		is_attacking = true
		$AnimatedSprite.play("Attack_1")
		var rock = ROCK.instance()
		if sign($Position2D.position.x) == 1:
			rock.set_rock(1)
		else:
			rock.set_rock(-1)
		get_parent().add_child(rock)
		rock.position = $Position2D.global_position
	
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
	is_attacking = false
