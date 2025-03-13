extends CanvasLayer


signal start_game
signal start_mp_game

func show_message(text_pass):
	$Message.text = text_pass
	$Message.show()
	
func show_get_ready_text():
	$Message.show()
	$Message.text = "3"
	await get_tree().create_timer(1.0).timeout
	$Message.text = "2"
	await get_tree().create_timer(1.0).timeout
	$Message.text = "1"
	await get_tree().create_timer(1.0).timeout
	$Message.text = "GO!"
	await get_tree().create_timer(1.0).timeout
	$Message.hide()

func reset_hud():
	$StartButton.show()
	$MPButton.show()
	$GameTitle.show()
	$Player1_score.hide()
	$Player2_score.hide()
	$Message.hide()
	$ScoredMessage.hide()
	
	
func _on_start_button_pressed():
	$StartButton.hide()
	$MPButton.hide()
	$GameTitle.hide()
	$Player1_score.show()
	$Player2_score.show()
	start_game.emit()

func _on_mp_button_pressed():
	$StartButton.hide()
	$MPButton.hide()
	$GameTitle.hide()
	$Player1_score.show()
	$Player2_score.show()
	start_mp_game.emit()
	
func update_player1_score(score, os_message):
	$Player1_score.text = "00"+str(score)
	if os_message:
		show_scored_message(1)

func update_player2_score(score, os_message):
	$Player2_score.text = "00"+str(score)
	if os_message:
		show_scored_message(2)

func show_scored_message(PlayerNumber):
	$ScoredMessage.text = "[b][color=red]Player " + str(PlayerNumber) +" scored ![/color][/b]"
	$ScoredMessage.show()
	await get_tree().create_timer(4.0).timeout
	$ScoredMessage.hide()
