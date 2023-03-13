cmake_minimum_required(VERSION 3.0)
project(cmake_test VERSION 0.0.1 LANGUAGES CXX)

# Prepare doctest for other targets to use
#find_package(doctest REQUIRED)

# Make test executable
add_executable(demo1 main.cpp lambda.cpp lambda.h doctest.h)
target_compile_features(demo1 PRIVATE cxx_std_17)
#target_link_libraries(tests PRIVATE doctest::doctest)

#include_directories(/usr/lib/llvm-15/include/c++/v1)

#SET (CMAKE_CXX_COMPILER             "/usr/bin/clang++")
#SET (CMAKE_CXX_FLAGS                "-Wall")
#SET (CMAKE_CXX_FLAGS_DEBUG          "-g")
#SET (CMAKE_CXX_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
#SET (CMAKE_CXX_FLAGS_RELEASE        "-O4 -DNDEBUG")
#SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g")

#SET (CMAKE_C_FLAGS_INIT                "-Wall -std=c11")
#SET (CMAKE_C_FLAGS_DEBUG_INIT          "-g")
#SET (CMAKE_C_FLAGS_MINSIZEREL_INIT     "-Os -DNDEBUG")
#SET (CMAKE_C_FLAGS_RELEASE_INIT        "-O3 -DNDEBUG")
#SET (CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-O2 -g")

#SET (CMAKE_CXX_FLAGS_INIT                "-Wall -std=c++17")
#SET (CMAKE_CXX_FLAGS_DEBUG_INIT          "-g")
#SET (CMAKE_CXX_FLAGS_MINSIZEREL_INIT     "-Os -DNDEBUG")
#SET (CMAKE_CXX_FLAGS_RELEASE_INIT        "-O3 -DNDEBUG")
#SET (CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O2 -g")
