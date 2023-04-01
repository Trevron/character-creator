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

# Main Node paths
@onready var hair_rear = $Body/Rig/Skeleton2D/HairRear
@onready var hair_front = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/HairFront
@onready var head = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/Head
@onready var eye_left = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/EyeLeft
@onready var eye_right = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/EyeRight
@onready var pupil_left = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/EyeLeft/PupilLeft
@onready var pupil_right = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/EyeRight/PupilRight
@onready var brow_left = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/BrowLeft
@onready var brow_right = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/BrowRight
@onready var mouth = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/Mouth
@onready var nose = $Body/Rig/Skeleton2D/TorsoBone/HeadBone/HeadGroup/Nose

# Limb Node Paths
@onready var upper_arm_left = $Body/Rig/Skeleton2D/TorsoBone/UpperArmLeftBone/UpperArmLeft
@onready var lower_arm_left = $Body/Rig/Skeleton2D/TorsoBone/UpperArmLeftBone/LowerLeftArmBone/LowerArmLeft
@onready var upper_arm_right = $Body/Rig/Skeleton2D/TorsoBone/UpperRightArmBone/UpperArmRight
@onready var lower_arm_right = $Body/Rig/Skeleton2D/TorsoBone/UpperRightArmBone/LowerRightArmBone/LowerArmRight
@onready var upper_leg_left = $Body/Rig/Skeleton2D/TorsoBone/UpperLegLeftBone/UpperLegLeft
@onready var lower_leg_left = $Body/Rig/Skeleton2D/TorsoBone/UpperLegLeftBone/LowerLegLeftBone/LowerLegLeft
@onready var upper_leg_right = $Body/Rig/Skeleton2D/TorsoBone/UpperLegRightBone/UpperLegRight
@onready var lower_leg_right = $Body/Rig/Skeleton2D/TorsoBone/UpperLegRightBone/LowerLegRightBone/LowerLegRight

func _ready():
	
	# Back Hair
	hair_rear.position = hair_position
	hair_rear.modulate = hair_color
	$Body/Rig/Skeleton2D/TorsoBone/HeadBone/RearHairTransform.position = hair_position
	
	# Front Hair
	hair_front.position = hair_position
	hair_front.modulate = hair_color
	
	# Left Eye
	eye_left.position = Vector2(-eye_distance, -eye_height)
	eye_left.scale = eye_scale
	eye_left.rotation_degrees = eye_rotation
	
	# Right Eye
	eye_right.position = Vector2(eye_distance, -eye_height)
	eye_right.scale = eye_scale
	eye_right.rotation_degrees = eye_rotation
	
	# Left Pupil
	pupil_left.scale = pupil_scale
	pupil_left.position = pupil_position
	pupil_left.modulate = pupil_color
	
	# Right Pupil
	pupil_right.scale = pupil_scale
	pupil_right.position = pupil_position
	pupil_right.modulate = pupil_color
	
	# Left Brow
	brow_left.position = Vector2(-brow_distance, -brow_height)
	brow_left.scale = brow_scale
	brow_left.modulate = hair_color
	
	# Right Brow
	brow_right.position = Vector2(brow_distance, -brow_height)
	brow_right.scale = brow_scale
	brow_right.modulate = hair_color
	
	# Nose
	nose.position = nose_position
	nose.scale = nose_scale
	
	# Mouth
	mouth.position = Vector2(0, -mouth_height)
	mouth.modulate = mouth_color
	
	# Head
	head.modulate = skin_color
	
	# Limbs
	color_limbs(skin_color)


func _on_hair_front_change(type: Change, payload):
	hair_front.change_request.emit(type, payload)


func _on_hair_rear_change(type: Change, payload):
	hair_rear.change_request.emit(type, payload)


func _on_head_change(type: Change, payload):
	head.change_request.emit(type, payload)


func _on_mouth_change(type: Change, payload):
	mouth.change_request.emit(type, payload)


func _on_nose_change(type: Change, payload):
	nose.change_request.emit(type, payload)


func _on_eye_change(type: Change, payload):
	eye_left.change_request.emit(type, payload)
	eye_right.change_request.emit(type, payload)


func _on_brow_change(type: Change, payload):
	brow_left.change_request.emit(type, payload)
	brow_right.change_request.emit(type, payload)


func _on_ear_change(type: Change, payload):
	$Head/Ear.change_request.emit(type, payload)


func _on_pupil_change(type: Change, payload):
	pupil_left.change_request.emit(type, payload)
	pupil_right.change_request.emit(type, payload)


func _on_randomize_character():
	hair_rear.randomize_everything()
	head.randomize_everything()
	hair_front.randomize_everything()
	brow_left.randomize_everything()
	brow_right.randomize_everything()
	eye_left.randomize_everything()
	eye_right.randomize_everything()
	pupil_left.randomize_everything()
	pupil_right.randomize_everything()
	mouth.randomize_everything()
	nose.randomize_everything()


func color_limbs(color: Color):
	upper_arm_left.modulate = color
	lower_arm_left.modulate = color
	upper_arm_right.modulate = color
	lower_arm_right.modulate = color
	upper_leg_left.modulate = color
	lower_leg_left.modulate = color
	upper_leg_right.modulate = color
	lower_leg_right.modulate = color
