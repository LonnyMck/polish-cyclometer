extends LineEdit

func _on_text_changed(new_text: String = '') -> void:
	var letters_123 = new_text.to_upper().split('', false) 
	
	text = new_text.to_upper()
	set_caret_column(letters_123.size())
