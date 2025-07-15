class_name NestedRes extends Resource

@export var name: String 
@export var number: int = 4

@export var _array: Array = ["hello", "world"]

#@export var deep_obj: DeepRes = load("res://data/deep/data/deep_1.tres").duplicate()
@export var deep_obj: DeepRes = load("res://data/deep/data/deep_1.tres")
#@export var deep_obj: DeepRes = DeepRes.new()

@export_storage var deep_array: Array[DeepRes] = [
	load("res://data/deep/data/deep_1.tres").duplicate(),
	load("res://data/deep/data/deep_1.tres").duplicate()
	]

@export var deep_editor_array: Array[DeepRes] : set = _set_deep_editor_array

func _set_deep_editor_array(new_value: Array[DeepRes]):
	for deep_res in new_value:
		var duplicated_deep_res = deep_res.duplicate()
		deep_editor_array.append(duplicated_deep_res)
