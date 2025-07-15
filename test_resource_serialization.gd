extends SceneTree

const FILE_PATH: String = "user://test_core_res.tres"
const TEST_RESULTS_PATH: String = "user://test_results.json"

var test_results = {
	"before_save": {},
	"after_restart": {},
	"passed": false,
	"errors": []
}

func _init():
	print("=== Starting Resource Serialization Test ===")
	
	# Step 1: Create and modify resource
	var my_core_res: CoreRes = CoreRes.new()
	
	# Modify the resource (simulate button press)
	my_core_res.text = "nuevo mundo"
	my_core_res.number = 6
	my_core_res._array = ["nuevo", "mundo"]
	my_core_res._dict["mundo"] = "nuevo"
	
	# Create nested resource
	var nested_res = NestedRes.new()
	nested_res.name = "test_nested"
	nested_res.number = 42
	nested_res._array = ["nested", "test"]
	
	# Create deep resource
	var deep_res = DeepRes.new()
	deep_res.text = "deep test"
	
	# Create deeper resource
	var deeper_res = DeeperRes.new()
	deeper_res.name = "deeper_test"
	deeper_res.flag = true
	
	# Link them together (use append for custom setters)
	deep_res.deeper_array.append(deeper_res)
	nested_res.deep_array.append(deep_res)
	my_core_res.nested_obj = nested_res
	
	# Step 2: Print values before saving
	print("--- BEFORE SAVE ---")
	print_resource_state(my_core_res, "before_save")
	
	# Step 3: Save resource
	var save_result = ResourceSaver.save(my_core_res, FILE_PATH)
	if save_result != OK:
		test_results.errors.append("Failed to save resource: " + str(save_result))
		quit_with_results()
		return
	
	print("Resource saved successfully")
	
	# Step 4: Clear reference and load from disk
	my_core_res = null
	my_core_res = load(FILE_PATH)
	
	if my_core_res == null:
		test_results.errors.append("Failed to load resource from disk")
		quit_with_results()
		return
	
	# Step 5: Print values after loading
	print("--- AFTER LOAD ---")
	print_resource_state(my_core_res, "after_restart")
	
	# Step 6: Compare results
	compare_results()
	
	# Step 7: Save test results and quit
	quit_with_results()

func print_resource_state(res: CoreRes, stage: String):
	var state = {
		"text": res.text,
		"number": res.number,
		"_array": res._array,
		"_dict": res._dict,
		"nested_obj": null
	}
	
	if res.nested_obj:
		state.nested_obj = {
			"name": res.nested_obj.name,
			"number": res.nested_obj.number,
			"_array": res.nested_obj._array,
			"deep_array": []
		}
		
		for deep_res in res.nested_obj.deep_array:
			var deep_state = {
				"text": deep_res.text,
				"deeper_array": []
			}
			
			for deeper_res in deep_res.deeper_array:
				deep_state.deeper_array.append({
					"name": deeper_res.name,
					"flag": deeper_res.flag
				})
			
			state.nested_obj.deep_array.append(deep_state)
	
	test_results[stage] = state
	
	# Print for visual inspection
	print("CoreRes.text: ", res.text)
	print("CoreRes.number: ", res.number)
	print("CoreRes._array: ", res._array)
	print("CoreRes._dict: ", res._dict)
	
	if res.nested_obj:
		print("NestedRes.name: ", res.nested_obj.name)
		print("NestedRes.number: ", res.nested_obj.number)
		print("NestedRes._array: ", res.nested_obj._array)
		
		if res.nested_obj.deep_array.size() > 0:
			print("DeepRes.text: ", res.nested_obj.deep_array[0].text)
			if res.nested_obj.deep_array[0].deeper_array.size() > 0:
				print("DeeperRes.name: ", res.nested_obj.deep_array[0].deeper_array[0].name)
				print("DeeperRes.flag: ", res.nested_obj.deep_array[0].deeper_array[0].flag)

func compare_results():
	print("--- COMPARISON ---")
	var before = test_results.before_save
	var after = test_results.after_restart
	
	var passed = true
	
	# Compare simple values
	if before.text != after.text:
		test_results.errors.append("Text mismatch: " + str(before.text) + " vs " + str(after.text))
		passed = false
	
	if before.number != after.number:
		test_results.errors.append("Number mismatch: " + str(before.number) + " vs " + str(after.number))
		passed = false
	
	# Compare arrays
	if not arrays_equal(before._array, after._array):
		test_results.errors.append("Array mismatch: " + str(before._array) + " vs " + str(after._array))
		passed = false
	
	# Compare dictionaries
	if not dicts_equal(before._dict, after._dict):
		test_results.errors.append("Dict mismatch: " + str(before._dict) + " vs " + str(after._dict))
		passed = false
	
	# Compare nested objects
	if before.nested_obj and after.nested_obj:
		if before.nested_obj.name != after.nested_obj.name:
			test_results.errors.append("Nested name mismatch")
			passed = false
		
		if before.nested_obj.number != after.nested_obj.number:
			test_results.errors.append("Nested number mismatch")
			passed = false
	
	test_results.passed = passed
	
	if passed:
		print("✅ TEST PASSED: All values match after save/load cycle")
	else:
		print("❌ TEST FAILED: Values don't match")
		for error in test_results.errors:
			print("  - " + error)

func arrays_equal(a1: Array, a2: Array) -> bool:
	if a1.size() != a2.size():
		return false
	for i in range(a1.size()):
		if a1[i] != a2[i]:
			return false
	return true

func dicts_equal(d1: Dictionary, d2: Dictionary) -> bool:
	if d1.size() != d2.size():
		return false
	for key in d1:
		if not d2.has(key) or d1[key] != d2[key]:
			return false
	return true

func quit_with_results():
	# Save results to file for inspection
	var results_file = FileAccess.open(TEST_RESULTS_PATH, FileAccess.WRITE)
	if results_file:
		results_file.store_string(JSON.stringify(test_results, "\t"))
		results_file.close()
	
	print("=== Test Results ===")
	print("Passed: ", test_results.passed)
	print("Results saved to: ", TEST_RESULTS_PATH)
	
	# Exit with appropriate code
	quit(0 if test_results.passed else 1)
