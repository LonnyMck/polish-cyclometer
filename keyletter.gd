extends Control
signal letter_of_switch


@export var label_text: String = '7'
@export var led_on: bool = false 

func LedisOn(is_on):
	$LedSwitch.button_pressed = is_on

#func SwitchIsOn(is_on): #rotates switch rectangle when on, vertical when off
	#$Switch.rotation = -20 if is_on else 0

# Called when the node enters the scene tree for the first time.

func changeLabel():
	$LetterLabel.text = label_text
	
func _ready() -> void:
	LedisOn(led_on)
	
	#SwitchIsOn(switch_on)
	
	

func _on_toggled(toggled_on: bool) -> void:
	print('toggled switch of ' + label_text)

	letter_of_switch.emit(label_text, toggled_on)
	#SwitchIsOn(toggled_on)
	


func _on_property_list_changed() -> void:
	#if (led_on || switch_on): print( label + str(led_on) + str(switch_on))
	$LedSwitch.disabled = $".".disabled
	LedisOn(led_on)
