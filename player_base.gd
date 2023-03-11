extends CharacterBody2D

signal head_change(dir: int)
signal change_skin_color(color: Color)
signal nose_change(dir: int)

signal change_hair_color(color: Color)
signal hair_front_change(dir: int)
signal hair_back_change(dir: int)

signal mouth_change(dir: int)
signal change_mouth_color(color: Color)
signal change_mouth_size(size: int)
signal change_mouth_height(height: int)

signal brow_change(dir: int)
signal change_brow_size(size: int)
signal change_brow_distance(distance: int)
signal change_brow_height(height: int)

signal eyes_change(dir: int)
signal change_eye_color(color: Color)
signal change_eye_size(size: int)
signal change_eye_distance(distance: int)
signal rotate_eyes(degrees: int)

# Utility variables
const scale_interval = 0.01

# Eyes
@export var eye_scale := Vector2(0.45, 0.45)
@export var eye_height := 20
@export var eye_distance := 60
@export var eye_rotation := 0

# Pupils
@export var pupil_position := Vector2(0,5)
@export var pupil_scale := Vector2(0.4, 0.4)
@export var pupil_color := Color("4b96a6")

# Brows
@export var brow_height := 50
@export var brow_distance := 60
@export var brow_scale := Vector2(0.5, 0.5)

# Skin
@export var skin_color := Color("ffd6bd")

# Hair
@export var hair_color := Color("c2c26b")
@export var hair_position := Vector2(0,200)

# Mouth
@export var mouth_height := -65
@export var mouth_scale := Vector2(0.5, 0.5)
@export var mouth_color := Color("ee9eae")

# Nose
@export var nose_position := Vector2(0, 35)
@export var nose_scale := Vector2(0.5, 0.5)


# Arrays for sprite resources
@onready var brows = []
@onready var hairs_back = []
@onready var hairs_front = []
@onready var heads = []
@onready var eyes = []
@onready var pupils = []
@onready var noses = []
@onready var mouths = []

# Sprite array indexes
var mouth_index := 0
var nose_index := 0
var eye_index := 0
var pupil_index := 0
var brow_index := 0
var head_index := 0
var hair_front_index := -1
var hair_back_index := -1


func _ready():
	# Load sprite resources into arrays
	set_dir_contents("res://Character/Brows/", brows)
	set_dir_contents("res://Character/Hairs/Back/", hairs_back)
	set_dir_contents("res://Character/Hairs/Front/", hairs_front)
	set_dir_contents("res://Character/Heads/", heads)
	set_dir_contents("res://Character/Eyes/", eyes)
	set_dir_contents("res://Character/Pupils/", pupils)
	set_dir_contents("res://Character/Noses/", noses)
	set_dir_contents("res://Character/Mouths/", mouths)
	
	# Back Hair
	$Head/BHair.position = hair_position
	$Head/BHair.modulate = hair_color
	if (hair_back_index == -1):
		$Head/BHair.texture = null
	else:
		$Head/BHair.texture = hairs_back[hair_back_index]
	
	# Front Hair
	$Head/FHair.position = hair_position
	$Head/FHair.modulate = hair_color
	if (hair_front_index == -1):
		$Head/FHair.texture = null
	else:
		$Head/FHair.texture = hairs_front[hair_front_index]
	
	# Left Eye
	$Head/EyeLeft.position = Vector2(-eye_distance, -eye_height)
	$Head/EyeLeft.scale = eye_scale
	$Head/EyeLeft.texture = eyes[eye_index]
	$Head/EyeLeft.rotation_degrees = eye_rotation
	
	# Right Eye
	$Head/EyeRight.position = Vector2(eye_distance, -eye_height)
	$Head/EyeRight.scale = eye_scale
	$Head/EyeRight.texture = eyes[eye_index]
	$Head/EyeRight.rotation_degrees = eye_rotation
	
	# Left Pupil
	$Head/EyeLeft/PupilLeft.scale = pupil_scale
	$Head/EyeLeft/PupilLeft.position = pupil_position
	$Head/EyeLeft/PupilLeft.modulate = pupil_color
	$Head/EyeLeft/PupilLeft.texture = pupils[pupil_index]
	
	# Right Pupil
	$Head/EyeRight/PupilRight.scale = pupil_scale
	$Head/EyeRight/PupilRight.position = pupil_position
	$Head/EyeRight/PupilRight.modulate = pupil_color
	$Head/EyeRight/PupilRight.texture = pupils[pupil_index]
	
	# Left Brow
	$Head/BrowLeft.position = Vector2(-brow_distance, -brow_height)
	$Head/BrowLeft.scale = brow_scale
	$Head/BrowLeft.texture = brows[brow_index]
	$Head/BrowLeft.modulate = hair_color
	
	# Right Brow
	$Head/BrowRight.position = Vector2(brow_distance, -brow_height)
	$Head/BrowRight.scale = brow_scale
	$Head/BrowRight.texture = brows[brow_index]
	$Head/BrowRight.modulate = hair_color
	
	# Nose
	$Head/Nose.position = nose_position
	$Head/Nose.texture = noses[nose_index]
	$Head/Nose.scale = nose_scale
	
	# Mouth
	$Head/Mouth.position = Vector2(0, -mouth_height)
	$Head/Mouth.texture = mouths[mouth_index]
	$Head/Mouth.modulate = mouth_color
	
	# Head
	$Head/Head.modulate = skin_color
	$Head/Head.texture = heads[head_index]

func _process(delta):
	var speed = 5
	if Input.is_action_pressed('ui_right'):
		position.x += speed
	if Input.is_action_pressed('ui_left'):
		position.x -= speed

# Loader for sprite resources
func set_dir_contents(path: String, arr: Array):
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
					arr.append(load(path + file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func _on_hair_front_change(dir):
	if hair_front_index + dir == hairs_front.size():
		hair_front_index = -1
	elif hair_front_index + dir == -2:
		hair_front_index = hairs_front.size() -1
	else:
		hair_front_index += dir
	if (hair_front_index == -1):
		$Head/FHair.texture = null
	else:
		$Head/FHair.texture = hairs_front[hair_front_index]


func _on_hair_back_change(dir):
	if hair_back_index + dir == hairs_back.size():
		hair_back_index = -1
	elif hair_back_index + dir == -2:
		hair_back_index = hairs_back.size() -1
	else:
		hair_back_index += dir
	if (hair_back_index == -1):
		$Head/BHair.texture = null
	else:
		$Head/BHair.texture = hairs_back[hair_back_index]
	


func _on_head_change(dir):
	if head_index + dir == heads.size():
		head_index = 0
	elif head_index + dir == -1:
		head_index = heads.size() -1
	else:
		head_index += dir
	$Head/Head.texture = heads[head_index]

func _on_mouth_change(dir):
	if mouth_index + dir == mouths.size():
		mouth_index = 0
	elif mouth_index + dir == -1:
		mouth_index = mouths.size() -1
	else:
		mouth_index += dir
	$Head/Mouth.texture = mouths[mouth_index]


func _on_nose_change(dir):
	if nose_index + dir == noses.size():
		nose_index = 0
	elif nose_index + dir == -1:
		nose_index = noses.size() -1
	else:
		nose_index += dir
	$Head/Nose.texture = noses[nose_index]


func _on_eyes_change(dir):
	if eye_index + dir == eyes.size():
		eye_index = 0
	elif eye_index + dir == -1:
		eye_index = eyes.size() -1
	else:
		eye_index += dir
	$Head/EyeLeft.texture = eyes[eye_index]
	$Head/EyeRight.texture = eyes[eye_index]


func _on_change_hair_color(color):
	hair_color = color
	$Head/BHair.modulate = hair_color
	$Head/FHair.modulate = hair_color
	$Head/BrowLeft.modulate = hair_color
	$Head/BrowRight.modulate = hair_color


func _on_change_eye_color(color):
	pupil_color = color
	$Head/EyeLeft/PupilLeft.modulate = pupil_color
	$Head/EyeRight/PupilRight.modulate = pupil_color


func _on_change_skin_color(color):
	skin_color = color
	$Head/Head.modulate = skin_color


func _on_change_mouth_color(color):
	mouth_color = color
	$Head/Mouth.modulate = mouth_color


func _on_change_eye_size(size):
	eye_scale = Vector2(size * scale_interval, size * scale_interval)
	$Head/EyeRight.scale = eye_scale
	$Head/EyeLeft.scale = eye_scale


func _on_rotate_eyes(degrees):
	eye_rotation = degrees
	$Head/EyeRight.rotation_degrees = eye_rotation
	$Head/EyeLeft.rotation_degrees = -eye_rotation


func _on_change_mouth_size(size):
	mouth_scale = Vector2(size * scale_interval, size * scale_interval)
	$Head/Mouth.scale = mouth_scale


func _on_change_mouth_height(height):
	mouth_height = height
	$Head/Mouth.position = Vector2(0, -mouth_height)


func _on_change_eye_distance(distance):
	eye_distance = distance
	$Head/EyeLeft.position = Vector2(-eye_distance, -eye_height)
	$Head/EyeRight.position = Vector2(eye_distance, -eye_height)


func _on_brow_change(dir):
	if brow_index + dir == brows.size():
		brow_index = -1
	elif brow_index + dir == -2:
		brow_index = brows.size() -1
	else:
		brow_index += dir
	if (brow_index == -1):
		$Head/BrowLeft.texture = null
		$Head/BrowRight.texture = null
	else:
		$Head/BrowLeft.texture = brows[brow_index]
		$Head/BrowRight.texture = brows[brow_index]


func _on_change_brow_distance(distance):
	brow_distance = distance
	$Head/BrowLeft.position = Vector2(-brow_distance, -brow_height)
	$Head/BrowRight.position = Vector2(brow_distance, -brow_height)


func _on_change_brow_height(height):
	brow_height = height
	$Head/BrowLeft.position = Vector2(-brow_distance, -brow_height)
	$Head/BrowRight.position = Vector2(brow_distance, -brow_height)


func _on_change_brow_size(size):
	brow_scale = Vector2(size * scale_interval, size * scale_interval)
	$Head/BrowLeft.scale = brow_scale
	$Head/BrowRight.scale = brow_scale
