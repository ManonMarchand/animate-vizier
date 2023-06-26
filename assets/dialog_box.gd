extends ColorRect

@export var dialogPath:String = "res://assets/dialog.json"
@export var textSpeed:float = 0.02

var dialog



var phrase_num:int = 0
var finished:bool = false 

func _ready():
	$"../Timer".wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
	
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$text.visible_characters = len($text.text)
	
func getDialog() -> Array:
	var file = FileAccess.get_file_as_string(dialogPath)
	var file_as_dict = JSON.parse_string(file)
	
	return file_as_dict

func nextPhrase() -> void:
	if phrase_num >= len(dialog):
		queue_free()
		return
		
	finished = false
	$text.bbcode_text = dialog[phrase_num]["text"]
	
	$text.visible_characters = 0
	while $text.visible_characters < len($text.text):
		$text.visible_characters += 1
		$"../Timer".start()
		await $"../Timer".timeout
		
	finished = true
	var step: int = dialog[phrase_num]["step"]
	print(step)
	match step:
		0: 
			$"../../step1".hide()
			$"../../step2".hide()
			$"../../step3".hide()
			$"../../step4".hide()
			$"../../step5".hide()
			$"../../logos/Ivoa".hide()
			$"../../logos/B2Find".hide()
			
		1:
			$"../../step1".show()
		2:
			$"../../step2".show()
		3:
			$"../../step3".show()
		4: 
			$"../../step4".show()
		5: 
			$"../../step5".show()
		6: 
			$"../../logos/Ivoa".show()
		7: 
			$"../../logos/B2Find".show()
		

	phrase_num += 1
	return

