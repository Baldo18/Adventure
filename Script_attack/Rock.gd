extends Area2D

const speed = 300
var velocity = Vector2()
var direction = 1

func set_rock(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true
		
func _physics_process(delta):
	velocity.x=speed * delta * direction
	translate(velocity)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Rock_body_entered(body):
	
	if "Enemy_1" in body.name:
		body.dead()
	queue_free()
