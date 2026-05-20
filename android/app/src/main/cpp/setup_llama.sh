#!/bin/bash

# Script to clone and setup llama.cpp for Android build
# Can be run from anywhere; resolves its own directory.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

LLAMA_CPP_DIR="llama.cpp"
LLAMA_CPP_COMMIT="7d2ba9b175e5c0897c007bb4e4b32a4bf6c308ff"

echo "Setting up llama.cpp for Android (commit ${LLAMA_CPP_COMMIT})..."

if [ -d "$LLAMA_CPP_DIR" ]; then
    echo "llama.cpp directory already exists. Checking out pinned commit..."
    cd "$LLAMA_CPP_DIR"
    git fetch origin
    git checkout "$LLAMA_CPP_COMMIT"
    cd ..
else
    echo "Cloning llama.cpp..."
    git clone https://github.com/ggerganov/llama.cpp.git
    cd "$LLAMA_CPP_DIR"
    git checkout "$LLAMA_CPP_COMMIT"
    cd ..
fi

echo "llama.cpp setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 'flutter pub get' to update dependencies"
echo "2. Build the Android app: 'flutter build apk' or run from Android Studio"
echo ""
echo "Note: The first build will take longer as it compiles llama.cpp native library"
