#!/bin/bash

GODOT_PATH="/Volumes/Fer/RespaldoFER/Documentos/GODOT/Editor/Executables/Godot_v4.4.1-stable_macos.universal.app/Contents/MacOS/Godot"
PROJECT_PATH="/Users/fernandobarahona/Documents/DiabloHumaStudio/load_disk_resourse_basics"

echo "🧪 Running Resource Serialization Test..."
echo "===============NOW GODOT PRINTS========================"

# Run the test script
"$GODOT_PATH" --headless --script test_resource_serialization.gd --path "$PROJECT_PATH"

echo "===============NOW BASH TEST RESULTS PRINTS========================"
# Check exit code
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ TEST PASSED!"
    echo "Check user://test_results.json for detailed results"
else
    echo ""
    echo "❌ TEST FAILED!"
    echo "Check user://test_results.json for detailed results"
    exit 1
fi