# ============================================================================
#
# Introduction
# ------------
# 
# This file is the main file for the tempile. The project follows the pattern
# laid out at http://tnick.github.io/ideas/2014/05/24/micromodules.html
# for a `pile-source`.
#
# Usage
# -----
# 
# ============================================================================

cmake_minimum_required(VERSION 2.8.11)

# make sure we find support modules
list (APPEND CMAKE_MODULE_PATH 
   "${CMAKE_SOURCE_DIR}/cmake/")
include (tempile)

# how to use it
if (TEMPILE_SHARED)
   # shared library
   tempileInit (SHARED)
else (TEMPILE_SHARED)
   # static library
   tempileInit (STATIC)
endif (TEMPILE_SHARED)

# ============================================================================
