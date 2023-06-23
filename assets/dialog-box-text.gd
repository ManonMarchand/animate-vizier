extends RichTextLabel

@export  var text_color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = text_color
	pass # Replace with function body.
