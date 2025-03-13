extends Node


var Player1_score
var Player2_score

var screen_size
var singlePlayer

func _ready():
	#new_game()
	pass
	
func quit_game():
	$Player1.hide()
	$Player2.hide()
	$StartScreen.reset_hud()
	$Ball.position=(Vector2(381,282))
	$Ball.velocity=Vector2(0,0)
	$Ball.hide()

func new_game():
	singlePlayer = true
	Player1_score = 0
	Player2_score = 0
	$StartScreen.update_player1_score(Player1_score, false)
	$StartScreen.update_player2_score(Player2_score, false)
	$Player2.ai_controlled = true
	$Player1.show()
	$Player2.show()
	$Ball.show()
	$StartScreen.show_get_ready_text()
	await get_tree().create_timer(4.0).timeout
	$Ball.give_initial_kick()

func new_mp_game():
	singlePlayer = false
	Player1_score = 0
	Player2_score = 0
	$StartScreen.update_player1_score(Player1_score, false)
	$StartScreen.update_player2_score(Player2_score, false)
	$Player1.show()
	$Player2.show()
	$Player2.ai_controlled = false
	$Ball.show()
	$StartScreen.show_get_ready_text()
	await get_tree().create_timer(4.0).timeout
	$Ball.give_initial_kick()

func reset_ball():
	$Ball.position=(Vector2(399,283))
	$Ball.velocity=Vector2(0,0)
	$StartScreen.show_get_ready_text()
	await get_tree().create_timer(4.0).timeout
	$Ball.give_initial_kick()

func _on_ball_left_screen_left():
	Player2_score += 1
	$StartScreen.update_player2_score(Player2_score, true)
	reset_ball()
	
func _on_ball_left_screen_right():
	Player1_score +=1
	$StartScreen.update_player1_score(Player1_score, true)
	reset_ball()
	
func _process(delta: float) -> void:
	if singlePlayer:
		$Player2.update_position(delta, $Ball.position.y)
	if Input.is_action_pressed("ui_cancel"):
		quit_game()
