extends CharacterBody2D

enum Change { HEIGHT, DISTANCE, SIZE, COLOR, FEATURE, ROTATION }

signal ear_change(type: Change, payload)
signal head_change(type: Change, payload)
signal nose_change(type: Change, payload)
signal hair_front_change(type: Change, payload)
signal hair_rear_change(type: Change, payload)
signal mouth_change(type: Change, payload)
signal brow_change(type: Change, payload)
signal eye_change(type: Change, payload)
signal pupil_change(type: Change, payload)
signal randomize_character()


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
@export var brow_rotation := 0

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

func _ready():
	
	# Back Hair
	$Head/HairRear.position = hair_position
	$Head/HairRear.modulate = hair_color

	
	# Front Hair
	$Head/HairFront.position = hair_position
	$Head/HairFront.modulate = hair_color
	
	# Left Eye
	$Head/EyeLeft.position = Vector2(-eye_distance, -eye_height)
	$Head/EyeLeft.scale = eye_scale
	$Head/EyeLeft.rotation_degrees = eye_rotation
	
	# Right Eye
	$Head/EyeRight.position = Vector2(eye_distance, -eye_height)
	$Head/EyeRight.scale = eye_scale
	$Head/EyeRight.rotation_degrees = eye_rotation
	
	# Left Pupil
	$Head/EyeLeft/PupilLeft.scale = pupil_scale
	$Head/EyeLeft/PupilLeft.position = pupil_position
	$Head/EyeLeft/PupilLeft.modulate = pupil_color
	
	# Right Pupil
	$Head/EyeRight/PupilRight.scale = pupil_scale
	$Head/EyeRight/PupilRight.position = pupil_position
	$Head/EyeRight/PupilRight.modulate = pupil_color
	
	# Left Brow
	$Head/BrowLeft.position = Vector2(-brow_distance, -brow_height)
	$Head/BrowLeft.scale = brow_scale
	$Head/BrowLeft.modulate = hair_color
	
	# Right Brow
	$Head/BrowRight.position = Vector2(brow_distance, -brow_height)
	$Head/BrowRight.scale = brow_scale
	$Head/BrowRight.modulate = hair_color
	
	# Nose
	$Head/Nose.position = nose_position
	$Head/Nose.scale = nose_scale
	
	# Mouth
	$Head/Mouth.position = Vector2(0, -mouth_height)
	$Head/Mouth.modulate = mouth_color
	
	# Head
	$Head/Head.modulate = skin_color


func _on_hair_front_change(type: Change, payload):
	$Head/HairFront.change_request.emit(type, payload)


func _on_hair_rear_change(type: Change, payload):
	$Head/HairRear.change_request.emit(type, payload)


func _on_head_change(type: Change, payload):
	$Head/Head.change_request.emit(type, payload)


func _on_mouth_change(type: Change, payload):
	$Head/Mouth.change_request.emit(type, payload)


func _on_nose_change(type: Change, payload):
	$Head/Nose.change_request.emit(type, payload)


func _on_eye_change(type: Change, payload):
	$Head/EyeLeft.change_request.emit(type, payload)
	$Head/EyeRight.change_request.emit(type, payload)


func _on_brow_change(type: Change, payload):
	$Head/BrowLeft.change_request.emit(type, payload)
	$Head/BrowRight.change_request.emit(type, payload)


func _on_ear_change(type: Change, payload):
	$Head/Ear.change_request.emit(type, payload)


func _on_pupil_change(type: Change, payload):
	$Head/EyeLeft/PupilLeft.change_request.emit(type, payload)
	$Head/EyeRight/PupilRight.change_request.emit(type, payload)


func _on_randomize_character():
	$Head/HairRear.randomize_everything()
	$Head/Head.randomize_everything()
	$Head/HairFront.randomize_everything()
	$Head/BrowLeft.randomize_everything()
	$Head/BrowRight.randomize_everything()
	$Head/EyeLeft.randomize_everything()
	$Head/EyeRight.randomize_everything()
	$Head/EyeLeft/PupilLeft.randomize_everything()
	$Head/EyeRight/PupilRight.randomize_everything()
	$Head/Mouth.randomize_everything()
	$Head/Nose.randomize_everything()
