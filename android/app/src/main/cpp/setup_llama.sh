#!/bin/bash

# Script to clone and setup llama.cpp for Android build
# Run this script from the android/app/src/main/cpp directory

set -e

LLAMA_CPP_DIR="llama.cpp"

echo "Setting up llama.cpp for Android..."

# Check if llama.cpp already exists
if [ -d "$LLAMA_CPP_DIR" ]; then
    echo "llama.cpp directory already exists. Updating..."
    cd $LLAMA_CPP_DIR
    git pull
    cd ..
else
    echo "Cloning llama.cpp..."
    git clone https://github.com/ggerganov/llama.cpp.git
fi

echo "llama.cpp setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 'flutter pub get' to update dependencies"
echo "2. Build the Android app: 'flutter build apk' or run from Android Studio"
echo ""
echo "Note: The first build will take longer as it compiles llama.cpp native library"
