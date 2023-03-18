class_name Feature extends Sprite2D

signal change_request(type: Change, payload)

enum Change { HEIGHT, DISTANCE, SIZE, COLOR, FEATURE, ROTATION }

var current_height : int
var current_distance : int
var current_size : int
var current_color : Color
var current_rotation : int
var current_position : Vector2
var scale_increment := 0.01
var is_left = false

var img_index = 0
@onready var img_features = []

func set_img_parts(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			# Check if folder, not needed now but keep for later
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if (".import" not in file_name):	
					## print("Found file: " + path + file_name)
					img_features.append(ResourceLoader.load(path + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func randomize_everything():
	randomize()
	#current_height = randi_range(-100, 0)
	#position = Vector2(0, -current_height)
	#current_size = randi_range(0, 100)
	#scale = Vector2(current_size * scale_increment, current_size * scale_increment)
	#current_color = Color(randf(), randf(), randf())
	#modulate = current_color
	img_index = randi_range(0, img_features.size() - 1)
	texture = img_features[img_index]


func change_height(height):
	current_height = height
	position.y = current_height


func change_distance(distance):
	if is_left:
		current_distance = -distance
	else:
		current_distance = distance
	position.x = current_distance


func change_size(size):
	current_size = size
	scale = Vector2(current_size * scale_increment, current_size * scale_increment)


func change_color(color):
	current_color = color
	modulate = current_color


func change_feature(dir):
	if img_index + dir == img_features.size():
		img_index = 0
	elif img_index + dir == -1:
		img_index = img_features.size() -1
	else:
		img_index += dir
	texture = img_features[img_index]


func change_rotation(degree):
	if is_left:
		current_rotation = -degree
	else:
		current_rotation = degree
	rotation_degrees = current_rotation


func _on_change_request(type: Change, payload):
	match (type):
		Change.HEIGHT:
			change_height(-payload)
		Change.DISTANCE:
			change_distance(payload)
		Change.SIZE:
			change_size(payload)
		Change.COLOR:
			change_color(payload)
		Change.FEATURE:
			change_feature(payload)
		Change.ROTATION:
			change_rotation(payload)
