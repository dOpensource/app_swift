#  CMakeLists.txt for app_swift -- A Cepstral Swift TTS engine interface
#  TODO: this is a WIP version for using the cmake toolchain (use make toolchain instead)
#
#  Copyright (C) 2021, dOpenSource
#
#  POC: Tyler Moore (@dOpenSource) <tmoore@goflyball.com>
#
#  This program is free software, distributed under the
#  terms of the GNU General Public License Version 2. See
#  the LICENSE file at the top of the source tree for more
#  information.

# Project name
set(PROJECT_NAME app_swift)
project(${PROJECT_NAME})

# Toolchain standards
cmake_minimum_required(VERSION 3.6)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)

# Version info
set(APP_SWIFT_VERSION master)
set(CMAKE_BUILD_TYPE RELEASE)

# Set project layout
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/built CACHE PATH "Single Directory for all")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/built CACHE PATH "Single Directory for all")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/built CACHE PATH "Single Directory for all")
set(CMAKE_LIBRARY_PATH /usr/lib)
set(CMAKE_INCLUDE_PATH /usr/include)

message("\n--------------------------------\n")
message("PROJECT NAME:\t\t${PROJECT_NAME}")
message("CMAKE_SYSTEM_NAME:\t${CMAKE_SYSTEM_NAME}")
message("CMAKE_C_COMPILER:\t${CMAKE_C_COMPILER}")
message("CMAKE_CXX_COMPILER:\t${CMAKE_CXX_COMPILER}")
message("CMAKE_GENERATOR:\t${CMAKE_GENERATOR}")
message("CMAKE_BUILD_TYPE:\t${CMAKE_BUILD_TYPE}")
message("CMAKE_BINARY_DIR:\t${CMAKE_BINARY_DIR}")
message("CMAKE_MODULE_PATH:\t${CMAKE_MODULE_PATH}")
message("CMAKE_PREFIX_PATH:\t${CMAKE_PREFIX_PATH}")
message("CMAKE_LIBRARY_PATH:\t${CMAKE_LIBRARY_PATH}")
message("CMAKE_INCLUDE_PATH:\t${CMAKE_INCLUDE_PATH}")
message("\n--------------------------------\n")

# Including dirs
# DEBUG: for testing on local machine add swift/asterisk headers here
#include_directories(BEFORE /usr/local/src/swift-tts/include)
#include_directories(BEFORE /usr/local/src/astinclude/)
include_directories(BEFORE ${CMAKE_INCLUDE_PATH})

# Enable tests with CTest
#enable_testing()

# Define src files
set(SOURCE_FILES ${PROJECT_NAME}.c)

# Define build targets
add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
set_target_properties(${PROJECT_NAME}
                      PROPERTIES PREFIX ""
                      LIBRARY_OUTPUT_NAME "${PROJECT_NAME}")
