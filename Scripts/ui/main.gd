extends CanvasLayer


func _on_settings_button_pressed():
	%PopupAnimationPlayer.play("popup_settings")
	
func _on_settings_back_button_pressed():
	%PopupAnimationPlayer.play_backwards("popup_settings")

func _on_credit_button_pressed():
	%PopupAnimationPlayer.play("popup_credits")

func _on_credits_back_button_pressed():
	%PopupAnimationPlayer.play_backwards("popup_credits")
