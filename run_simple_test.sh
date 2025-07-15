#!/bin/bash

GODOT_PATH="/Volumes/Fer/RespaldoFER/Documentos/GODOT/Editor/Executables/Godot_v4.4.1-stable_macos.universal.app/Contents/MacOS/Godot"
PROJECT_PATH="/Users/fernandobarahona/Documents/DiabloHumaStudio/load_disk_resourse_basics"

echo "🧪 Running Simple Test..."
echo "===============NOW GODOT PRINTS========================"

# Run the simple test script
"$GODOT_PATH" --headless --script test_res_ser_simple.gd --path "$PROJECT_PATH"
EXIT_CODE=$?
echo "===============NOW BASH TEST RESULTS PRINTS========================"
# Check exit code
if [ $EXIT_CODE -eq 0 ]; then
    echo ""
    echo "✅ SIMPLE TEST PASSED!"
else
    echo ""
    echo "❌ SIMPLE TEST FAILED!"
    exit 1
fi