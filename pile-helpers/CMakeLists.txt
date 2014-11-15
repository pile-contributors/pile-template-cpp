# ============================================================================
#
# Introduction
# ------------
# 
# This file is the main file for the tempile-helpers. The project follows 
# the pattern laid out at http://tnick.github.io/ideas/2014/05/24/micromodules.html
# for a `pile-helpers` repository.
#
# Usage
# -----
# 
# ============================================================================

project(tempile-helpers)
cmake_minimum_required(VERSION 2.8.11)

# make sure we find support modules
list (APPEND CMAKE_MODULE_PATH 
   "${CMAKE_SOURCE_DIR}/cmake/"
   "${CMAKE_SOURCE_DIR}/tempile-src/cmake/")
include(tempile)

# how to use it

# including the sources directly
tempileInit (PILE)

# creating a library out of our source
add_subdirectory(tempile-src)

# copy all headers to build/include/tempile
message(STATUS ${TEMPILE_HEADERS})
add_custom_target(
    copy_tempile_headers ALL
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/build/include/tempile"
    COMMENT "MsgPile headers are being copied"
    VERBATIM
    DEPENDS tempile)
foreach (iter_h ${TEMPILE_HEADERS})
    get_filename_component (iter_h_name ${iter_h} NAME)
    add_custom_command (
        TARGET copy_tempile_headers
        PRE_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different "${iter_h}" "${CMAKE_BINARY_DIR}/build/include/tempile/${iter_h_name}")
endforeach (iter_h ${TEMPILE_HEADERS})

add_subdirectory(live-test)


# ============================================================================
