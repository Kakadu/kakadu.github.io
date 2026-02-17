cmake_minimum_required(VERSION 3.10)
project(cmake_test VERSION 0.0.1 LANGUAGES CXX)

# Make test executable
add_executable(demo1 main.cpp lambda.cpp lambda.h doctest.h)
target_compile_features(demo1 PRIVATE cxx_std_17)
#target_link_libraries(tests PRIVATE doctest::doctest)

#include_directories(/usr/lib/llvm-15/include/c++/v1)

SET (CMAKE_CXX_FLAGS                "-Wno-write-strings")
