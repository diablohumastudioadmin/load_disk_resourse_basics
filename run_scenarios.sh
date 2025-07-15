#!/bin/bash

GODOT_PATH="/Volumes/Fer/RespaldoFER/Documentos/GODOT/Editor/Executables/Godot_v4.4.1-stable_macos.universal.app/Contents/MacOS/Godot"
PROJECT_PATH="/Users/fernandobarahona/Documents/DiabloHumaStudio/load_disk_resourse_basics"

echo "🧪 Running Resource Serialization Scenarios..."
echo "=============================================="

# Run the scenario tests
"$GODOT_PATH" --headless --script test_scenarios.gd --path "$PROJECT_PATH"

echo ""
echo "✅ All scenarios completed!"