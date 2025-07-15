class_name CoreRes extends Resource

@export_storage var text: String = "Hola Mundo"
@export_storage var number: int = 5

@export_storage var _array: Array = ["hola", "mundo"]
@export_storage var _dict: Dictionary = {"mundo": "hola"}

#@export_storage var nested_obj: NestedRes = load("res://data/nested/data/nested_1.tres")
@export_storage var nested_obj: NestedRes = load("res://data/nested/data/nested_1.tres").duplicate(true)
#@export_storage var nested_obj: NestedRes = NestedRes.new()

func _init() -> void:
	#nested_obj.name = "createdObj1"
	pass
