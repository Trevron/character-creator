extends Node

const scale_multiplier = 100

@onready var player = $Window/Portrait/PlayerBase

func _ready():
	
	# Initialize Colors
	$Interface/Colors/Hair/Color.color = player.hair_color
	$Interface/Colors/Eyes/Color.color = player.pupil_color
	$Interface/Colors/Skin/Color.color = player.skin_color
	$Interface/Colors/Mouth/Color.color = player.mouth_color
	
	# Initialize Sliders
	$Interface/Mouth/MouthSize/Size.value = player.mouth_scale.x * scale_multiplier
	$Interface/Mouth/MouthHeight/Height.value = player.mouth_height
	$Interface/Eyes/EyeSize/Size.value = player.eye_scale.x * scale_multiplier
	$Interface/Eyes/EyeDistance/Distance.value = player.eye_distance
	$Interface/Eyes/EyeRotation/Rotation.value = player.eye_rotation
	$Interface/Brows/BrowHeight/Height.value = player.brow_height
	$Interface/Brows/BrowDistance/Distance.value = player.brow_distance
	$Interface/Brows/BrowSize/Size.value = player.brow_scale.x * scale_multiplier


func _on_hair_front_previous_pressed():
	player.hair_front_change.emit(-1)


func _on_hair_front_next_pressed():
	player.hair_front_change.emit(1)


func _on_hair_back_previous_pressed():
	player.hair_back_change.emit(-1)


func _on_hair_back_next_pressed():
	player.hair_back_change.emit(1)


func _on_head_previous_pressed():
	player.head_change.emit(-1)


func _on_head_next_pressed():
	player.head_change.emit(1)


func _on_mouth_previous_pressed():
	player.mouth_change.emit(-1)


func _on_mouth_next_pressed():
	player.mouth_change.emit(1)


func _on_nose_previous_pressed():
	player.nose_change.emit(-1)


func _on_nose_next_pressed():
	player.nose_change.emit(1)


func _on_brow_previous_pressed():
	player.brow_change.emit(-1)


func _on_brow_next_pressed():
	player.brow_change.emit(1)


func _on_brow_height_value_changed(value):
	player.change_brow_height.emit(value)


func _on_brow_distance_value_changed(value):
	player.change_brow_distance.emit(value)


func _on_brow_size_value_changed(value):
	player.change_brow_size.emit(value)


func _on_eyes_previous_pressed():
	player.eyes_change.emit(-1)


func _on_eyes_next_pressed():
	player.eyes_change.emit(1)


func _on_hair_color_changed(color):
	player.change_hair_color.emit(color)


func _on_eye_color_changed(color):
	player.change_eye_color.emit(color)


func _on_skin_color_changed(color):
	player.change_skin_color.emit(color)


func _on_mouth_color_changed(color):
	player.change_mouth_color.emit(color)


func _on_mouth_size_value_changed(value):
	player.change_mouth_size.emit(value)


func _on_eye_size_value_changed(value):
	player.change_eye_size.emit(value)


func _on_eye_rotation_value_changed(value):
	player.rotate_eyes.emit(value)


func _on_mouth_height_value_changed(value):
	player.change_mouth_height.emit(value)


func _on_eye_distance_value_changed(value):
	player.change_eye_distance.emit(value)
