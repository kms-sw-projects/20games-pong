extends RigidBody2D
var speed=350
var velocity = Vector2.ZERO # The ball's movement vector.
var screen_size
signal left_screen_left
signal left_screen_right

func give_initial_kick():
	velocity.x = ((-1)**randi())
	velocity.y = ((-1)**randi())*randf()
	
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
func _process(delta):
	#print()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	#position += velocity*delta
	position = position.clamp(Vector2.ZERO, screen_size)
	var collision_object = move_and_collide(velocity*delta)
	if collision_object:
		velocity = velocity.bounce(collision_object.get_normal())
		$BounceSound.play()
	if position.x < 0:
		left_screen_left.emit()
		$ScoreSound.play()
	if position.x > screen_size[0]:
		left_screen_right.emit()
		$ScoreSound.play()
