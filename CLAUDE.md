# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Godot 4.4 project that demonstrates how Godot handles resource loading and saving to disk. The project explores different scenarios of resource serialization, including objects created with `new()` vs `load()`, and how `@export_storage` annotations affect persistence.

## Architecture

### Global Systems (Autoloaded)
- `SceneManagerSystem`: Handles scene transitions with parameter passing
- `UserDataSystem`: Currently empty but autoloaded for future user data management

### Data Model Structure
The project uses a 4-layer nested resource hierarchy:
- `CoreRes`: Main resource class with various property types (text, number, _array, _dict, nested_obj)
- `NestedRes`: Second layer resource within CoreRes
- `DeepRes`: Third layer resource for deep nesting tests
- `DeeperRes`: Fourth layer resource for maximum nesting depth

### Key Files
- `project.godot`: Main Godot project configuration
- `explain.md`: Detailed Spanish documentation about Godot resource serialization behavior
- `screens/menu_1/menu_1.gd`: Main test interface demonstrating resource operations
- `data/core_res/core_res.gd`: CoreRes class definition
- `data/nested/nested.gd`: NestedRes class definition
- `data/deep/deep_nested.gd`: DeepRes class definition
- `data/deeper/deeper.gd`: DeeperRes class definition
- `data/*/data/*.tres`: Serialized resource files
- `test_resource_serialization.gd`: Automated test script
- `test_scenarios.gd`: Multiple scenario test script

## Development Commands

### Godot Executable Path
```bash
/Volumes/Fer/RespaldoFER/Documentos/GODOT/Editor/Executables/Godot_v4.4.1-stable_macos.universal.app/Contents/MacOS/Godot
```

### Running the Project
```bash
# Run the project directly from command line
godot --path /path/to/project

# Run in headless mode (no GUI)
godot --headless --path /path/to/project

# Run with debugging
godot --debug --path /path/to/project

# Run and quit after first iteration (useful for testing)
godot --quit --path /path/to/project
```

### Testing and Validation
```bash
# Check project for errors only (no execution)
godot --check-only --script /path/to/script.gd

# Import resources and quit (useful for CI)
godot --import --path /path/to/project

# Run with verbose output
godot --verbose --path /path/to/project

# Run with specific resolution for testing
godot --resolution 1920x1080 --path /path/to/project
```

### Export Commands
```bash
# Export release build
godot --export-release "preset_name" /path/to/output/game.exe

# Export debug build
godot --export-debug "preset_name" /path/to/output/game.exe

# Export data pack only
godot --export-pack "preset_name" /path/to/output/game.pck
```

### Testing Resource Serialization

#### Manual Testing (Editor)
The project demonstrates:
1. Loading resources from disk vs creating with `new()`
2. How `@export_storage` affects serialization
3. Nested resource handling
4. Memory optimization behavior when reloading resources

#### Automated Testing (Fast)
```bash
# Run comprehensive serialization test (~2-3 seconds)
./run_test.sh

# Test different resource creation scenarios
./run_scenarios.sh

# Run specific test directly
godot --headless --script test_resource_serialization.gd --path .
```

**Test Features:**
- Complete save/load cycle simulation
- Automatic before/after state comparison
- Tests all nested resource levels (CoreRes → NestedRes → DeepRes → DeeperRes)
- JSON output with detailed results
- Multiple scenario testing (new() vs load() vs mixed)

**How Tests Work:**
- Tests inherit from `SceneTree` to run as standalone applications
- `--script` mode bypasses normal scene loading and runs test logic directly
- Tests create resources programmatically, save/load them, and compare states
- Much faster than manual editor testing (~2-3 seconds vs minutes)

## Key Concepts

### Resource Serialization Behavior
- Resources created with `new()` create subresources when saved
- Resources loaded with `load()` maintain external references
- `@export_storage` is required for properties to persist
- Nested objects behave differently based on creation method

### Scene Management
Use `SceneManagerSystem.change_scene(scene, arguments)` for scene transitions with parameter passing.

### File Locations
- User data saves to `user://core_res.tres`
- Resource definitions:
  - `res://data/core_res/core_res.gd`
  - `res://data/nested/nested.gd`
  - `res://data/deep/deep_nested.gd`
  - `res://data/deeper/deeper.gd`
- Test data in `res://data/*/data/`
- Test results in `user://test_results.json`