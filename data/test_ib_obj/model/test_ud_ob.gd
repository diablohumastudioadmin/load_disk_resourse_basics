class_name TestUdObj extends Resource

@export_storage var simple_string: String = "Hola Mundo"
@export_storage var simple_int: int = 5

@export_storage var simple_array: Array = ["hola", "mundo"]
@export_storage var simple_dictionary: Dictionary = {"mundo": "hola"}

#@export_storage var simple_object: InternalTestUdObj = load("res://data/internal_test_ud_obj/data/new_internal_test_ud_obj_1.tres")
@export_storage var simple_object: InternalTestUdObj = load("res://data/internal_test_ud_obj/data/new_internal_test_ud_obj_1.tres").duplicate(true)
#@export_storage var simple_object: InternalTestUdObj = InternalTestUdObj.new()

func _init() -> void:
	#simple_object.name = "createdObj1"
	pass
