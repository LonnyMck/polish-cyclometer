extends LineEdit

func _on_text_changed(new_text: String) -> void:
	var text_input = new_text.to_upper().split('', false) 
	text = new_text.to_upper()
	set_caret_column(text_input.size())

func updateText(new_text: String ) -> void:
	text = new_text
	


	
