class_name InternalTestUdObj extends Resource

@export var name: String 
@export var int_simple_int: int = 4

@export var int_simple_array: Array = ["hello", "world"]

#@export var int_simple_object: InternalInternalTestUdObj = load("res://data/internal_internal_test_ud_obj/data/int_int_r_ud_obj_1.tres").duplicate()
@export var int_simple_object: InternalInternalTestUdObj = load("res://data/internal_internal_test_ud_obj/data/int_int_r_ud_obj_1.tres")
#@export var int_simple_object: InternalInternalTestUdObj = InternalInternalTestUdObj.new()

@export_storage var int_object_arrat: Array[InternalInternalTestUdObj] = [
	load("res://data/internal_internal_test_ud_obj/data/int_int_r_ud_obj_1.tres").duplicate(),
	load("res://data/internal_internal_test_ud_obj/data/int_int_r_ud_obj_1.tres").duplicate()
	]

@export var int_object_editor_arrar: Array[InternalInternalTestUdObj] : set = _set_int_object_editor_arrar

func _set_int_object_editor_arrar(new_value: Array[InternalInternalTestUdObj]):
	for int_int_ts_udobj in new_value:
		var duplicated_int_int_ts_udobj = int_int_ts_udobj.duplicate()
		int_object_editor_arrar.append(duplicated_int_int_ts_udobj)
