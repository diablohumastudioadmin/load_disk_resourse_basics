class_name InternalInternalTestUdObj extends Resource

@export var int_int_simple_string: String = "yiello uorld"
@export var int_int_int_array: Array[IntIntIntTestUdObj] = [] : set = _set_int_int_int_array

func _set_int_int_int_array(new_value: Array[IntIntIntTestUdObj]):
	for int_int_int_obj in new_value:
		var dupli_iiio = int_int_int_obj.duplicate()
		int_int_int_array.append(dupli_iiio)
