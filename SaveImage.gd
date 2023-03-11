extends Button

var root = 'user://'
var filename = 'saved_character.png'
var fullpath = ''

func _on_pressed():
	$SaveDialog.visible = true

func _on_save_dialog_dir_selected(dir):
	root = dir


func _on_save_dialog_canceled():
	$SaveDialog.visible = false


func _on_save_dialog_file_selected(path):
	fullpath = path
	$SaveDialog.visible = false
	save_file()
	

func save_file():
	var img:Image = get_parent().get_parent().get_node('Window/Portrait').get_viewport().get_texture().get_image()
	var error = img.save_png(fullpath)
	if (error):
		print(error)
	else:
		print('Success')
