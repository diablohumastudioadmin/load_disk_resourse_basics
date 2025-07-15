extends SceneTree

const FILE_PATH: String = "user://test_core_res.tres"

enum STAGES {BEFORE_SAVE, AFTER_SAVE}

var test_results = {
	"before_save": {},
	"after_restart": {},
	"passed": false,
	"errors": []
}

func _init():
	print("=== Starting Resource Serialization Test ===")
	var core_res: CoreRes = load("res://data/core_res/data/core_res.tres")
	var original_core_res: CoreRes = load("res://data/core_res/data/core_res.tres").duplicate()
	print_relevant_values(core_res, "Just loaded core_res from res://")
#region Change Relevant Values
	core_res.number = 777
	core_res.text = "new world"
	core_res._array = ["new","world"]
	core_res._dict = {"new": "world"}
	core_res = load("res://data/core_res/data/core_res.tres")
	core_res.nested_obj.name  = "nuevo NESTED nombre"
	core_res.nested_obj.deep_array = [load("res://data/deep/data/deep_1.tres")]
	core_res.nested_obj.deep_array[0].text = "nuevo deep nombre"
	core_res.nested_obj.deep_array[0].deeper_array[0].flag = true
#endregion
	print_relevant_values(core_res, "changed core_res")
	var save_result = ResourceSaver.save(core_res, FILE_PATH)
	assert(save_result == OK, "Fail do save")
	print("---------")
	print("-------resourse has been saved ---------------")
	print("---------")
	core_res = null
	await create_timer(.2).timeout
	core_res = load_core_res_from_file(FILE_PATH)
	print_relevant_values(core_res, "loaded core_res from user://")
	print_relevant_values(original_core_res, "original core_res loaded from res://")
	if core_res.nested_obj.name == original_core_res.nested_obj.name:
		quit(1)
	if core_res.nested_obj.deep_array[0].text  == original_core_res.nested_obj.deep_array[0].text :
		quit(1)
	if core_res.nested_obj.deep_array[0].deeper_array[0].flag == original_core_res.nested_obj.deep_array[0].deeper_array[0].flag:
		quit(1)
	quit(0)

func load_core_res_from_file(file_path:String):
	return load(file_path)

func print_relevant_values(core_res: CoreRes, title: String):
	var core_int: int = core_res.number
	var core_string: String = core_res.text
	var core_array: Array = core_res._array
	var core_dict: Dictionary = core_res._dict
	var nestedObj_name : String = core_res.nested_obj.name
	var nestedObj_array : Array = core_res.nested_obj.deep_array
	var deepObj_string : String = core_res.nested_obj.deep_array[0].text
	var deeperObj_flag : bool = core_res.nested_obj.deep_array[0].deeper_array[0].flag
	
	print("------------------------------------------")
	print("FROM " + title)
	print("------------------------------------------")
	printt(core_res, core_int, core_string)
	print(core_array)
	print(core_dict)
	print(nestedObj_name )
	print(nestedObj_array )
	print(deepObj_string )
	print(deeperObj_flag )

func _print_resource_stat(res: CoreRes, stage: STAGES):
	res.get_property_list()
	
