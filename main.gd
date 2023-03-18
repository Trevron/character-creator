extends Node

const scale_multiplier = 100

@onready var player = $PlayerBase
enum Change { HEIGHT, DISTANCE, SIZE, COLOR, FEATURE, ROTATION }

func _ready():
	set_control_positions()


func set_control_positions():
	# Initialize Colors
	$Interface/Colors/Hair/Color.color = player.hair_color
	$Interface/Colors/Eyes/Color.color = player.pupil_color
	$Interface/Colors/Skin/Color.color = player.skin_color
	$Interface/Colors/Mouth/Color.color = player.mouth_color
	
	# Initialize Sliders
	$Interface/Mouth/MouthSize/Size.value = player.mouth_scale.x * scale_multiplier
	$Interface/Mouth/MouthHeight/Height.value = player.mouth_height
	$Interface/Pupils/PupilSize/Size.value = player.pupil_scale.x * scale_multiplier
	$Interface/Eyes/EyeSize/Size.value = player.eye_scale.x * scale_multiplier
	$Interface/Eyes/EyeDistance/Distance.value = player.eye_distance
	$Interface/Eyes/EyeRotation/Rotation.value = player.eye_rotation
	$Interface/Brows/BrowHeight/Height.value = player.brow_height
	$Interface/Brows/BrowDistance/Distance.value = player.brow_distance
	$Interface/Brows/BrowSize/Size.value = player.brow_scale.x * scale_multiplier
	$Interface/Brows/BrowRotation/Rotation.value = player.brow_rotation


func randomize_control_values():
	randomize()
	# Initialize Colors
	$Interface/Colors/Hair/Color.color_changed.emit(Color(randf(), randf(), randf()))
	$Interface/Colors/Eyes/Color.color_changed.emit(Color(randf(), randf(), randf()))
	$Interface/Colors/Skin/Color.color_changed.emit(Color(randf(), randf(), randf()))
	$Interface/Colors/Mouth/Color.color_changed.emit(Color(randf(), randf(), randf()))
	
	# Initialize Sliders
	$Interface/Mouth/MouthSize/Size.value = randi_range(0, 100) 
	$Interface/Mouth/MouthHeight/Height.value = randi_range(-120, 0)
	$Interface/Pupils/PupilSize/Size.value = randi_range(0, 100) 
	$Interface/Eyes/EyeSize/Size.value = randi_range(0, 100) 
	$Interface/Eyes/EyeDistance/Distance.value = randi_range(0, 100)
	$Interface/Eyes/EyeRotation/Rotation.value = randi_range(-180, 180)
	$Interface/Brows/BrowHeight/Height.value = randi_range(0, 120)
	$Interface/Brows/BrowDistance/Distance.value = randi_range(0, 100)
	$Interface/Brows/BrowSize/Size.value = randi_range(0, 100) 
	$Interface/Brows/BrowRotation/Rotation.value = randi_range(-180, 180)

func _on_hair_front_previous_pressed():
	player.hair_front_change.emit(Change.FEATURE, -1)


func _on_hair_front_next_pressed():
	player.hair_front_change.emit(Change.FEATURE, 1)


func _on_hair_back_previous_pressed():
	player.hair_rear_change.emit(Change.FEATURE, -1)


func _on_hair_back_next_pressed():
	player.hair_rear_change.emit(Change.FEATURE, 1)


func _on_head_previous_pressed():
	player.head_change.emit(Change.FEATURE, -1)


func _on_head_next_pressed():
	player.head_change.emit(Change.FEATURE, 1)


func _on_mouth_previous_pressed():
	player.mouth_change.emit(Change.FEATURE, -1)


func _on_mouth_next_pressed():
	player.mouth_change.emit(Change.FEATURE, 1)


func _on_nose_previous_pressed():
	player.nose_change.emit(Change.FEATURE, -1)


func _on_nose_next_pressed():
	player.nose_change.emit(Change.FEATURE, 1)


func _on_brow_previous_pressed():
	player.brow_change.emit(Change.FEATURE, -1)


func _on_brow_next_pressed():
	player.brow_change.emit(Change.FEATURE, 1)


func _on_brow_height_value_changed(value):
	player.brow_change.emit(Change.HEIGHT, value)


func _on_brow_distance_value_changed(value):
	player.brow_change.emit(Change.DISTANCE, value)


func _on_brow_size_value_changed(value):
	player.brow_change.emit(Change.SIZE, value)


func _on_brow_rotation_value_changed(value):
	player.brow_change.emit(Change.ROTATION, value)


func _on_eyes_previous_pressed():
	player.eye_change.emit(Change.FEATURE, -1)


func _on_eyes_next_pressed():
	player.eye_change.emit(Change.FEATURE, 1)


func _on_hair_color_changed(color):
	player.hair_front_change.emit(Change.COLOR, color)
	player.hair_rear_change.emit(Change.COLOR, color)
	player.brow_change.emit(Change.COLOR, color)


func _on_eye_color_changed(color):
	player.pupil_change.emit(Change.COLOR, color)


func _on_skin_color_changed(color):
	player.head_change.emit(Change.COLOR, color)


func _on_mouth_color_changed(color):
	player.mouth_change.emit(Change.COLOR, color)


func _on_mouth_size_value_changed(value):
	player.mouth_change.emit(Change.SIZE, value)


func _on_mouth_height_value_changed(value):
	player.mouth_change.emit(Change.HEIGHT, value)


func _on_eye_size_value_changed(value):
	player.eye_change.emit(Change.SIZE, value)


func _on_eye_rotation_value_changed(value):
	player.eye_change.emit(Change.ROTATION, value)


func _on_eye_distance_value_changed(value):
	player.eye_change.emit(Change.DISTANCE, value)


func _on_pupil_previous_pressed():
	player.pupil_change.emit(Change.FEATURE, -1)


func _on_pupil_next_pressed():
	player.pupil_change.emit(Change.FEATURE, 1)


func _on_pupil_size_value_changed(value):
	player.pupil_change.emit(Change.SIZE, value)


func _on_randomize_pressed():
	player.randomize_character.emit()
	randomize_control_values()
