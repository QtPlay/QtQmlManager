# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)

function(QtCopyQmlTo directory)
  string(COMPARE EQUAL "${directory}" "" is_empty)
  if(is_empty)
    message(FATAL_ERROR "Directory name expected as a first argument")
  endif()

  string(COMPARE NOTEQUAL "${ARGN}" "" not_empty)
  if(not_empty)
    message(FATAL_ERROR "Unexpected arguments: ${ARGN}")
  endif()

  string(COMPARE EQUAL "${QT_ROOT}" "" is_empty)
  if(is_empty)
    message(
        FATAL_ERROR
        "QT_ROOT is empty (probably hunter_add_package(Qt) missing)"
    )
  endif()

  file(REMOVE_RECURSE "${directory}")
  file(MAKE_DIRECTORY "${directory}")

  file(GLOB_RECURSE qml_list RELATIVE "${QT_ROOT}/qml" "${QT_ROOT}/qml/*")
  foreach(x ${qml_list})
    if("${x}" MATCHES "\\.a$")
      # skip
    elseif("${x}" MATCHES "\\.prl$")
      # skip
    elseif("${x}" MATCHES "\\.qmltypes$")
      # skip
    else()
      get_filename_component(suffix "${x}" DIRECTORY)
      file(COPY "${QT_ROOT}/qml/${x}" DESTINATION "${directory}/${suffix}")
    endif()
  endforeach()
endfunction()
