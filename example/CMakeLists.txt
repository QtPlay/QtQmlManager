# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)
include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.12.24.tar.gz"
    SHA1 "a25a7fa55c204a8126efd1f48593a662925b26da"
)
project(Example)

hunter_add_package(Qt)

set(qml_dir "${CMAKE_CURRENT_BINARY_DIR}/qml")
set(expected_file "${qml_dir}/QtMultimedia/Video.qml")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../cmake")
include(QtCopyQmlTo)

if(EXISTS "${expected_file}")
  message(FATAL_ERROR "Unexpected file: ${expected_file}")
endif()

QtCopyQmlTo(${qml_dir})

if(NOT EXISTS "${expected_file}")
  message(FATAL_ERROR "File not found: ${expected_file}")
endif()
