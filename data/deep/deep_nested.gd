class_name DeepRes extends Resource

@export var text: String = "yiello uorld"
@export var deeper_array: Array[DeeperRes] = [] : set = _set_deeper_array

func _set_deeper_array(new_value: Array[DeeperRes]):
	for deeper_obj in new_value:
		var duplicated_deeper = deeper_obj.duplicate()
		deeper_array.append(duplicated_deeper)