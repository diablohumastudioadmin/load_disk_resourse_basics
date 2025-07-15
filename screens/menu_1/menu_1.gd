extends Control

const FILE_PATH: String = "user://core_res.tres"

@onready var menu_2: PackedScene = load("res://screens/menu_2/menu_2.tscn")
var my_core_res : CoreRes = load("res://data/core_res/data/core_res.tres")
#var my_core_res : CoreRes = load(FILE_PATH)
#var my_core_res: CoreRes = CoreRes.new()
#var my_core_res = Resource.new()

func _on_change_ud_obj_string_btn_pressed() -> void:
	my_core_res.text = "nuevo mundo"
	my_core_res.number = 6

	my_core_res._array = ["nuevo", "mundo"]
	my_core_res._dict["mundo"] = "nuevo"
	
	#var new_nested_obj : NestedRes = load("res://data/nested/data/nested_2.tres")
	#var new_nested_obj : NestedRes = load("res://data/nested/data/nested_2.tres").duplicate()
	#var new_nested_obj : NestedRes = NestedRes.new()
	#new_nested_obj.name = "creat_obj_2"
	#new_nested_obj.name = "Nombre 3"
	#my_core_res.nested_obj = new_nested_obj
	my_core_res.nested_obj.deep_array[0].text = "deep world"
	my_core_res.nested_obj.deep_array[0].deeper_array[0].flag = true

func _on_save_ud_obj_btn_pressed() -> void:
	ResourceSaver.save(my_core_res, FILE_PATH)

func _on_print_ud_obj_string_btn_pressed() -> void:
	%PrintUdObjStringLabel.text = my_core_res.text
	print(my_core_res._array)
	print(my_core_res._dict)
	print(my_core_res.nested_obj.name)
	print(my_core_res.nested_obj.deep_array[0].text)
	print(my_core_res.nested_obj.deep_array[0].deeper_array[0].flag)

func _on_goto_menu_2_btn_pressed() -> void:
	SceneManagerSystem.change_scene(menu_2)

func _on_load_ud_obj_btn_pressed() -> void:
	my_core_res = load(FILE_PATH)
