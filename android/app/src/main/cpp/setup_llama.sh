#!/bin/bash

# Script to clone and setup llama.cpp for Android build
# Can be run from anywhere; resolves its own directory.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

LLAMA_CPP_DIR="llama.cpp"
LLAMA_CPP_REPO="https://github.com/ggerganov/llama.cpp.git"
# Pinned release tag from https://github.com/ggerganov/llama.cpp/releases
LLAMA_CPP_TAG="b7783"
LLAMA_CPP_COMMIT="d1e3556481c8b351f9b7b69ba3febf6cb77fffa6"

echo "Setting up llama.cpp for Android (tag ${LLAMA_CPP_TAG}, commit ${LLAMA_CPP_COMMIT})..."

if [ -d "$LLAMA_CPP_DIR" ]; then
    echo "llama.cpp directory already exists. Checking out pinned release..."
    cd "$LLAMA_CPP_DIR"
    git fetch --depth 1 origin tag "$LLAMA_CPP_TAG" 2>/dev/null || git fetch origin
    git checkout "$LLAMA_CPP_COMMIT"
    cd ..
else
    echo "Cloning llama.cpp..."
    git clone --depth 1 --branch "$LLAMA_CPP_TAG" "$LLAMA_CPP_REPO" "$LLAMA_CPP_DIR"
fi

echo "llama.cpp setup complete!"
echo ""
echo "Next steps:"
echo "1. Run 'flutter pub get' to update dependencies"
echo "2. Build the Android app: 'flutter build apk' or run from Android Studio"
echo ""
echo "Note: The first build will take longer as it compiles llama.cpp native library"
