extends Control 	


export var item_strings:PoolStringArray = []
export var spacing:float = 10
export var speed:float = 100
export var separator_texture:Texture = null
export var separator_size:Vector2 = Vector2(10, 10)

var item_string_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_initial()


func most_right():
	if $Items.get_child_count() == 0:
		return 0
	else:
		var last_child = $Items.get_children()[-1]
		return last_child.rect_position.x + last_child.rect_size.x


func load_initial():
	if len(item_strings) == 0:
		return

	while most_right() < rect_size.x:
		add_next_item()


func add_next_item():
	var label = RichTextLabel.new()
	
	label.text = item_strings[item_string_index]
	item_string_index += 1
	if item_string_index > len(item_strings) - 1:
		item_string_index = 0
	
	var font = label.get_font("normal_font")
	var size = font.get_string_size(label.text)
	label.rect_size = size + Vector2(1, 0)
	
	var x = most_right() + spacing
	var y = (rect_size.y - font.get_ascent()) / 2
	label.rect_position = Vector2(x, y)
	
	label.scroll_active = false
	$Items.add_child(label)
	
	if separator_texture:
		var separator = TextureRect.new()
		separator.texture = separator_texture
		
		x = most_right() + spacing
		separator.expand = true
		separator.rect_size = separator_size
		y = (rect_size.y - separator.rect_size.y) / 2
		separator.rect_position = Vector2(x, y)
		$Items.add_child(separator)


func _process(delta):
	for item in $Items.get_children():
		item.rect_position.x -= delta * speed
		
		if item.rect_position.x + item.rect_size.x < 0:
			item.queue_free()
	
	if len(item_strings) > 0 and most_right() < rect_size.x:
		add_next_item()
