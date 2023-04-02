extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time = OS.get_time()
	
	var ampm = "AM" if time.hour < 12 else "PM"

	if time.hour == 0:
		time.hour = 12
	
	var time_string = "%d:%02d %s" % [time.hour, time.minute, ampm]
	$Label.text = time_string

	var font = $Label.get_font("normal_font")
	$Label.rect_size.x = font.get_string_size(time_string).x + 1
