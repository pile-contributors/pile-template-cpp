# ============================================================================
#
# This file hosts all tests.
#
# If INCLUDE_PILE_SOURCES_DIRECTLY is ON then TEMPILE_SOURCES and
# TEMPILE_HEADERS are defined we add them to the executable. TEMPILE_LIBRARY
# is empty.
#
# On the other hand if INCLUDE_PILE_SOURCES_DIRECTLY is
# OFF then TEMPILE_SOURCES and TEMPILE_HEADERS are empty and we link
# against TEMPILE_LIBRARY that is now the name of the target that
# builds the library.
#
# ============================================================================

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

if (NOT INCLUDE_PILE_SOURCES_DIRECTLY)
    set (TEMPILE_LIBRARY tempile)
endif()

add_executable(test_basic
    ${TEMPILE_SOURCES}
    ${TEMPILE_HEADERS}
    basic.cc)

target_link_libraries(test_basic
    ${GTEST_BOTH_LIBRARIES}
    ${TEMPILE_LIBRARY})

add_test(
    NAME test_basic
    COMMAND $<TARGET_FILE:test_basic>)
