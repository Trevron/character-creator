extends Feature

func _ready():
	set_img_parts("res://Character/Eyes/")
	texture = img_features[img_index]
	is_left = true
