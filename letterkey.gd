extends Control

@export var letter = '#';

func LedisOn(is_on): #turns square white when on (true), black when off (false)
	$LedLight.color = Color('#ffffff' if is_on else '#000000')

func SwitchIsOn(is_on): #rotates switch rectangle when on, vertical when off
	$Switch.rotation = -20 if is_on else 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LedisOn(false)
	SwitchIsOn(true)
	$Label.text = letter

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
