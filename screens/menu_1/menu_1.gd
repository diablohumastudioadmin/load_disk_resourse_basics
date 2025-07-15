extends Control

const FILE_PATH: String = "user://obj1.tres"

@onready var menu_2: PackedScene = load("res://screens/menu_2/menu_2.tscn")
var my_test_ud_obj : TestUdObj = load("res://data/test_ib_obj/data/new_test_ud_obj.tres")
#var my_test_ud_obj : TestUdObj = load(FILE_PATH)
#var my_test_ud_obj: TestUdObj = TestUdObj.new()
#var my_test_ud_obj = Resource.new()
#var my_test_ud_obj = load("res://data/internal_test_ud_obj/data/new_resource.tres")

func _on_change_ud_obj_string_btn_pressed() -> void:
	my_test_ud_obj.simple_string = "nuevo mundo"
	my_test_ud_obj.simple_int = 6

	my_test_ud_obj.simple_array = ["nuevo", "mundo"]
	my_test_ud_obj.simple_dictionary["mundo"] = "nuevo"
	
	#var new_internal_object : InternalTestUdObj = load("res://data/internal_test_ud_obj/data/new_internal_test_ud_obj_2.tres")
	#var new_internal_object : InternalTestUdObj = load("res://data/internal_test_ud_obj/data/new_internal_test_ud_obj_2.tres").duplicate()
	#var new_internal_object : InternalTestUdObj = InternalTestUdObj.new()
	#new_internal_object.name = "creat_obj_2"
	#new_internal_object.name = "Nombre 3"
	#my_test_ud_obj.simple_object = new_internal_object
	my_test_ud_obj.simple_object.int_object_arrat[0].int_int_simple_string = "deep world"
	my_test_ud_obj.simple_object.int_object_arrat[0].int_int_int_array[0].my_bool_var = true

func _on_save_ud_obj_btn_pressed() -> void:
	ResourceSaver.save(my_test_ud_obj, FILE_PATH)

func _on_print_ud_obj_string_btn_pressed() -> void:
	%PrintUdObjStringLabel.text = my_test_ud_obj.simple_string
	print(my_test_ud_obj.simple_array)
	print(my_test_ud_obj.simple_dictionary)
	print(my_test_ud_obj.simple_object.name)
	print(my_test_ud_obj.simple_object.int_object_arrat[0].int_int_simple_string)
	print(my_test_ud_obj.simple_object.int_object_arrat[0].int_int_int_array[0].my_bool_var)

func _on_goto_menu_2_btn_pressed() -> void:
	SceneManagerSystem.change_scene(menu_2)

func _on_load_ud_obj_btn_pressed() -> void:
	my_test_ud_obj = load(FILE_PATH)
