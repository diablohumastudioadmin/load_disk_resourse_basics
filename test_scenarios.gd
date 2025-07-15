extends SceneTree

# Test different resource creation scenarios
func _init():
	print("=== Testing Different Resource Creation Scenarios ===")
	
	test_scenario_1_new_resources()
	test_scenario_2_loaded_resources()
	test_scenario_3_mixed_resources()
	
	print("=== All scenario tests completed ===")
	quit(0)

func test_scenario_1_new_resources():
	print("\n--- Scenario 1: All resources created with .new() ---")
	
	var core_res = CoreRes.new()
	core_res.text = "new_test"
	core_res.nested_obj = NestedRes.new()
	core_res.nested_obj.name = "new_nested"
	
	var deep_res = DeepRes.new()
	deep_res.text = "new_deep"
	deep_res.deeper_array.append(DeeperRes.new())
	core_res.nested_obj.deep_array.append(deep_res)
	
	save_and_test(core_res, "user://scenario_1.tres")

func test_scenario_2_loaded_resources():
	print("\n--- Scenario 2: Resources loaded from disk ---")
	
	var core_res = load("res://data/core_res/data/core_res.tres")
	core_res.text = "loaded_test"
	
	save_and_test(core_res, "user://scenario_2.tres")

func test_scenario_3_mixed_resources():
	print("\n--- Scenario 3: Mixed new() and loaded resources ---")
	
	var core_res = CoreRes.new()
	core_res.text = "mixed_test"
	core_res.nested_obj = load("res://data/nested/data/nested_1.tres")
	core_res.nested_obj.name = "mixed_nested"
	
	save_and_test(core_res, "user://scenario_3.tres")

func save_and_test(resource: Resource, file_path: String):
	# Save
	var save_result = ResourceSaver.save(resource, file_path)
	if save_result != OK:
		print("❌ Save failed: ", save_result)
		return
	
	# Load and compare
	var loaded_resource = load(file_path)
	if loaded_resource == null:
		print("❌ Load failed")
		return
	
	print("✅ Save/Load successful for ", file_path)
	print("   Text: ", loaded_resource.text)
	if loaded_resource.nested_obj:
		print("   Nested name: ", loaded_resource.nested_obj.name)