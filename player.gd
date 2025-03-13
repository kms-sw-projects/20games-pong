extends CharacterBody2D

var screen_size
var speed=250
var ai_controlled=false

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	#print()
	velocity = Vector2.ZERO # The player's movement vector.
	if self.name == "Player1":
		if Input.is_action_pressed("move_down_p1") :
			velocity.y += 1
		if Input.is_action_pressed("move_up_p1"):
			velocity.y -= 1
		
	if self.name == "Player2" and !(self.ai_controlled):
		if Input.is_action_pressed("move_down_p2") :
			velocity.y += 1
		if Input.is_action_pressed("move_up_p2"):
			velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity*delta
	position = position.clamp(Vector2(0,66), screen_size-Vector2(0,66))


func start(pos):
	position = pos
	show()

func update_position(delta, ball_y):
	if ball_y > position.y:
		velocity.y += speed*0.4
	elif ball_y < position.y:
		velocity.y -= speed*0.4
	position += velocity*delta
	position = position.clamp(Vector2.ZERO, screen_size)
