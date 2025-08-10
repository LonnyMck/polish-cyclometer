extends Control



const ABCS = ['A', 'B', 'C', 'D','E', 'F', 'G', 'H', 'I', 
		'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
		'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

#rotor I
const I = {
	'A': 'E', 'B': 'K', 'C': 'M', 'D': 'F', 'E': 'L', 'F': 'G',
	'G': 'D', 'H': 'Q', 'I': 'V', 'J': 'Z', 'K': 'N', 'L': 'T',
	'M': 'O', 'N': 'W', 'O': 'Y', 'P': 'H', 'Q': 'X', 'R': 'U',
	'S': 'S', 'T': 'P', 'U': 'A', 'V': 'I', 'W': 'B', 'X': 'R',
	'Y': 'C', 'Z': 'J'
}

#rotor II
const II = {
	'A': 'A', 'B': 'J', 'C': 'D', 'D': 'K', 'E': 'S', 'F': 'I',
	'G': 'R', 'H': 'U', 'I': 'X', 'J': 'B', 'K': 'L', 'L': 'H',
	'M': 'W', 'N': 'T', 'O': 'M', 'P': 'C', 'Q': 'Q', 'R': 'G',
	'S': 'Z', 'T': 'N', 'U': 'P', 'V': 'Y', 'W': 'F', 'X': 'V',
	'Y': 'O', 'Z': 'E'
}

# Rotor III (Enigma I)
const III = {
	'A': 'B', 'B': 'D', 'C': 'F', 'D': 'H', 'E': 'J', 'F': 'L',
	'G': 'C', 'H': 'P', 'I': 'R', 'J': 'T', 'K': 'X', 'L': 'V',
	'M': 'Z', 'N': 'N', 'O': 'Y', 'P': 'E', 'Q': 'I', 'R': 'W',
	'S': 'G', 'T': 'A', 'U': 'K', 'V': 'M', 'W': 'U', 'X': 'S',
	'Y': 'Q', 'Z': 'O'
}

const rotor_array = [I, II, III]

# Reflector A
const A_ref = {
	'A': 'E', 'B': 'J', 'C': 'M', 'D': 'Z', 'E': 'A', 'F': 'L',
	'G': 'Y', 'H': 'X', 'I': 'V', 'J': 'B', 'K': 'W', 'L': 'F',
	'M': 'C', 'N': 'R', 'O': 'Q', 'P': 'U', 'Q': 'O', 'R': 'N',
	'S': 'T', 'T': 'S', 'U': 'P', 'V': 'I', 'W': 'K', 'X': 'H',
	'Y': 'G', 'Z': 'D'
}

# Reflector B
const B_ref = {
	'A': 'Y', 'B': 'R', 'C': 'U', 'D': 'H', 'E': 'Q', 'F': 'S',
	'G': 'L', 'H': 'D', 'I': 'P', 'J': 'X', 'K': 'N', 'L': 'G',
	'M': 'O', 'N': 'K', 'O': 'M', 'P': 'I', 'Q': 'E', 'R': 'B',
	'S': 'F', 'T': 'Z', 'U': 'C', 'V': 'W', 'W': 'V', 'X': 'J',
	'Y': 'A', 'Z': 'T'
}


	
func removeDuplicates(array):
	var d := {}
	for n in array:
		if not n in d:
			d[n] = null # anything as value, using just keys
	var unique_values := d.keys()
	return unique_values

func findLetters456(letters_123):
	if letters_123.size() != 3: 
		%Letters456.text = ''
		return
	
	#this takes each letter and turns it into a number based on its position in the alphabet
	var letters_456 = [ABCS.find(letters_123[0]), ABCS.find(letters_123[1]), ABCS.find(letters_123[2])]
	
	letters_456[2] += 3 #shift last letter 3 forwards
	
	# if you cross Z, shift second letter once
	if letters_456[2] >= 26: letters_456[1] += 1 
	
	#if you cross Z, shift first letter once
	if letters_456[1] >= 26: letters_456[0] += 1 
	
	var str_output := '' 
	for i in letters_456:
		#append letters represented by numbers in letters_456
		str_output += ABCS[i % 26] 
		
	%Letters456.text = str_output
	
	return letters_456



var char_code = [] #variable to save six letter input given

#cyclometer functions
func rotateRotor(rotor, position):
	var shift = ABCS.find(position)
	var rotated = {}
	for i in range(26):
		var input_letter = ABCS[i]
		# Find the shifted index for input
		var shifted_input = ABCS[(i + shift) % 26]
		# Apply rotor wiring to shifted input
		var mapped_output = rotor[shifted_input]
		# Adjust output back by the same shift
		var adjusted_output = ABCS[(ABCS.find(mapped_output) - shift) % 26]
		# Assign final mapping
		rotated[input_letter] = adjusted_output
	return rotated

func rotorProcess(letter, rotor1, rotor2, rotor3, reflector): #letter goes through rotor like enigma machine
	var l1 = rotor3[letter]
	var l2 = rotor2[l1]
	var l3 = rotor1[l2]
	var reflected = reflector[l3]
	
	var l4
	var l5
	var l6
	
	for key in rotor1:
		if reflected == rotor1[key]: 
			l4 = key
			break
	for key in rotor2:
		if l4 == rotor2[key]: 
			l5 = key
			break
	for key in rotor3:
		if l5 == rotor3[key]: 
			l6 = key
			break
	return l6
	
func cyclometer( char_code = ['A','A','A','A','A','D'], I = I, II = II, III = III, reflector = A_ref):

	# === LEFT ROTOR SYSTEM ===
	var I_l = rotateRotor(I, char_code[0])
	var II_l = rotateRotor(II, char_code[1])
	var III_l = rotateRotor(III, char_code[2])

	var I_r = rotateRotor(I, char_code[3])
	var II_r = rotateRotor(II, char_code[4])
	var III_r = rotateRotor(III, char_code[5])

	# === FIRST PASS ===
	var letter_list = []
	var code_list = []
	for ch in ABCS:
		if letter_list.has(ch): continue
		
		var left_loop = []
		var right_loop = []
		var current_ch = ch
		for i in range(13):
			right_loop.append(current_ch)
			letter_list.append(current_ch)
			current_ch = rotorProcess(current_ch, I_l, II_l, III_l, reflector)
			left_loop.append(current_ch)
			letter_list.append(current_ch)
			current_ch = rotorProcess(current_ch, I_r, II_r, III_r, reflector)
		
		left_loop = removeDuplicates(left_loop)
		right_loop = removeDuplicates(right_loop)
		left_loop.append_array(right_loop) #can seperate these into right and left loop if you ever need to
		code_list.append(left_loop)
		#code_list.append(right_loop)
	return code_list
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func updateLetterKey() -> void:
	var char_list = ( %Letters123.text + %Letters456.text).to_upper().split('', false)
	print(char_list)
	
	if %AutomateCheckBox.button_pressed: 
		print('automatic!')
	
	if char_list.size() != 6:
		$LetterOutputs.turnOffLedsAndSwitches(true)
		return
	$LetterOutputs.turnOffLedsAndSwitches(false)
	
	var slow_rotor = rotor_array[ %OptRotorSlow.selected ]
	var mid_rotor = rotor_array[ %OptRotorMid.selected ]
	var fast_rotor =  rotor_array[ %OptRotorFast.selected ]
	var reflector = B_ref if %OptReflector.selected == 0 else A_ref
	
	var code_list = cyclometer(char_list, slow_rotor, mid_rotor, fast_rotor, reflector)
	$LetterOutputs.updateCodeList(code_list)

	


func _on_check_button_toggled(toggled_on: bool) -> void:
	%Letters456.editable = !toggled_on
	if toggled_on: _on_letters_123_text_changed(%Letters123.text)


func _on_letters_123_text_changed(new_text: String) -> void:
	var letters_123 = new_text.to_upper().split('', false)
	if %AutomateCheckBox.button_pressed: findLetters456(letters_123)
	updateLetterKey()

func _on_letters_456_text_changed(new_text: String) -> void:
	updateLetterKey()


func _on_opt_reflector_item_selected(index: int) -> void:
	updateLetterKey()


func _on_opt_rotor_fast_item_selected(index: int) -> void:
	updateLetterKey()


func _on_opt_rotor_mid_item_selected(index: int) -> void:
	updateLetterKey()


func _on_opt_rotor_slow_item_selected(index: int) -> void:
	updateLetterKey()
