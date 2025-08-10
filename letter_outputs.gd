class_name LetterOutputs extends HFlowContainer

const LetterScene = preload("res://keyletter.tscn")


const ABCS = ['A', 'B', 'C', 'D','E', 'F', 'G', 'H', 'I', 
		'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
		'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']


var code_list 

func turnOffLedsAndSwitches(is_disabled: bool = false): #sets all leds back to off
	for i in range(26):
		get_child(i).led_on = false
		get_child(i).disabled = is_disabled
		get_child(i).property_list_changed.emit()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ch in range(get_child_count()): #connects all letters to this class so can be turned on off etc
		get_child(ch).letter_of_switch.connect($"."._on_letter_of_switch)
		get_child(ch).label_text = ABCS[ch]
		get_child(ch).changeLabel()


func updateCodeList(text_input: Array ) -> void:
	turnOffLedsAndSwitches()
	print ('code: ' +  ''.join(text_input) )
	code_list = text_input

	

func _on_letter_of_switch(letter_switched: String = 'A', toggled_on: bool = true) -> void:
	
	turnOffLedsAndSwitches()
	
	if not toggled_on: return
	
	for sub_list in code_list:
		if not (sub_list.has(letter_switched)): continue
		for letter in sub_list:
			get_node(letter).led_on = true;
			get_node(letter).property_list_changed.emit()
