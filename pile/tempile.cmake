# ============================================================================
#
# Introduction
# ------------
# 
# This file contains cmake script used to initialize tempile. The project 
# follows the pattern laid out at 
# http://tnick.github.io/ideas/2014/05/24/micromodules.html
# for `./cmake/pile.cmake`.
#
# Usage
# -----
# 
# tempileInit() is used to initialize the project to a particular 
# configuration. It supports STATIC to create a static library, SHARED
# to create a shared library and PILE to let the importer include
# source files themselves.
# ============================================================================
macro (tempileDependencies)
    set (TEMPILE_DEPENDENCIES
    )
endmacro (tempileDependencies msg)

macro (tempileDebug msg)
    set (TEMPILE_DEBUG_MSG ON)
    if (TEMPILE_DEBUG_MSG)
        message (STATUS "TEMPILE: ${msg}")
    endif (TEMPILE_DEBUG_MSG)
endmacro (tempileDebug msg)

macro (tempileInit TEMPILE_USE_MODE)

    # set the name
    if (NOT DEFINED TEMPILE_NAME)
        set (TEMPILE_NAME "tempile")
    endif (NOT DEFINED  TEMPILE_NAME)
    string (TOUPPER ${TEMPILE_NAME} TEMPILE_NAME_U)
    string (TIMESTAMP TEMPILE_BUILD_TIME UTC)
    tempileDebug ("${TEMPILE_NAME} (${TEMPILE_NAME_U}) at ${TEMPILE_BUILD_TIME} as ${TEMPILE_USE_MODE}")

    # the version
    if (NOT DEFINED TEMPILE_MAJOR_VERSION)
        set (TEMPILE_MAJOR_VERSION 0)
        set (TEMPILE_MINOR_VERSION 0)
        set (TEMPILE_PATCH_VERSION 1)
        set (TEMPILE_VERSION_STRING
                "${TEMPILE_MAJOR_VERSION}.${TEMPILE_MINOR_VERSION}.${TEMPILE_PATCH_VERSION}")
    endif (NOT DEFINED TEMPILE_MAJOR_VERSION)
    tempileDebug ("version ${TEMPILE_VERSION_STRING}")

    # debug version can be set using TEMPILE_DEBUG
    if (NOT DEFINED TEMPILE_DEBUG)
        if (CMAKE_BUILD_TYPE STREQUAL "Debug")
            set (TEMPILE_DEBUG ON)
        else (CMAKE_BUILD_TYPE STREQUAL "Debug")
            set (TEMPILE_DEBUG OFF)
        endif (CMAKE_BUILD_TYPE STREQUAL "Debug")
    endif (NOT DEFINED TEMPILE_DEBUG)
    tempileDebug ("debug: ${TEMPILE_DEBUG}")

    # locate source directory if no default was provided
    if (NOT DEFINED TEMPILE_SOURCE_DIR)
        find_path(TEMPILE_SOURCE_DIR "tempile-config.h.in"
            PATHS
                "${CMAKE_SOURCE_DIR}"
                "${CMAKE_SOURCE_DIR}/.."
                "${CMAKE_SOURCE_DIR}/tempile"
                "${CMAKE_SOURCE_DIR}/tempile-src")
    endif (NOT DEFINED TEMPILE_SOURCE_DIR)
    tempileDebug ("TEMPILE_SOURCE_DIR: ${TEMPILE_SOURCE_DIR}")

    # locate destination directory if no default was provided
    if (NOT DEFINED TEMPILE_OUTPUT_DIR)
        set (TEMPILE_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}")
    endif (NOT DEFINED TEMPILE_OUTPUT_DIR)
    tempileDebug ("TEMPILE_OUTPUT_DIR: ${TEMPILE_OUTPUT_DIR}")

    # the type f output to generate
    if ("${TEMPILE_USE_MODE}" STREQUAL "STATIC")
        set (TEMPILE_STATIC ON)
        set (TEMPILE_PILE   OFF)
        set (TEMPILE_SHARED OFF)
        tempileDebug ("static version")
    elseif ("${TEMPILE_USE_MODE}" STREQUAL "PILE")
        set (TEMPILE_STATIC OFF)
        set (TEMPILE_PILE   ON)
        set (TEMPILE_SHARED OFF)
        tempileDebug ("custom version")
    elseif ("${TEMPILE_USE_MODE}" STREQUAL "SHARED")
        set (TEMPILE_STATIC OFF)
        set (TEMPILE_PILE   OFF)
        set (TEMPILE_SHARED ON)
        tempileDebug ("shared version")
    endif ("${TEMPILE_USE_MODE}" STREQUAL "STATIC")

    # create a configuration file for the project
    configure_file (
        "${TEMPILE_SOURCE_DIR}/tempile-config.h.in"
        "${TEMPILE_OUTPUT_DIR}/tempile/tempile-config.h")
    include_directories (${TEMPILE_OUTPUT_DIR})

    # compose the list of headers and sources
    set (TEMPILE_HEADERS
        "${TEMPILE_SOURCE_DIR}/tempile/tempile.h"
        "${TEMPILE_OUTPUT_DIR}/tempile/tempile-config.h")
    set (TEMPILE_SOURCES
        "${TEMPILE_SOURCE_DIR}/tempile/tempile.cc")

    # create the library if required
    if ("${TEMPILE_USE_MODE}" STREQUAL "STATIC")
        add_library (${TEMPILE_NAME} STATIC
            ${TEMPILE_HEADERS}
            ${TEMPILE_SOURCES})
    elseif ("${TEMPILE_USE_MODE}" STREQUAL "SHARED")
        add_library (${TEMPILE_NAME} SHARED
            ${TEMPILE_HEADERS}
            ${TEMPILE_SOURCES})
        set_target_properties (
            ${TEMPILE_NAME}
            PROPERTIES
                COMPILE_FLAGS -DTEMPILE_SHARED)
    endif ("${TEMPILE_USE_MODE}" STREQUAL "STATIC")


endmacro (tempileInit)
# ============================================================================
