cmake_minimum_required(VERSION 3.18.1)

project("llama-android")

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Configure for Android cross-compilation
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Disable llama.cpp features not needed for Android
set(GGML_NATIVE OFF CACHE BOOL "Disable native optimization" FORCE)
set(LLAMA_BUILD_EXAMPLES OFF CACHE BOOL "Disable examples" FORCE)
set(LLAMA_BUILD_TESTS OFF CACHE BOOL "Disable tests" FORCE)
set(LLAMA_BUILD_SERVER OFF CACHE BOOL "Disable server" FORCE)
set(LLAMA_CURL OFF CACHE BOOL "Disable curl" FORCE)
set(LLAMA_BUILD_COMMON OFF CACHE BOOL "Disable common" FORCE)
set(GGML_OPENMP OFF CACHE BOOL "Disable OpenMP" FORCE)

# Set ARM architecture flags for Android
set(GGML_NATIVE_DEFAULT OFF)

# Add llama.cpp source
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp ${CMAKE_CURRENT_BINARY_DIR}/llama-build)

# Create our JNI library
add_library(llama-android SHARED
    llama_android.cpp
)

# Include directories
target_include_directories(llama-android PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp/include
    ${CMAKE_CURRENT_SOURCE_DIR}/llama.cpp/common
)

# Link libraries
target_link_libraries(llama-android
    llama
    log
    android
)
