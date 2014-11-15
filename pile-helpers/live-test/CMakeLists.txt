# ============================================================================
#
# Builds a gui executable that makes use of tempile
#
# ============================================================================

include_directories ("${PROJECT_BINARY_DIR}/build/include")

add_executable (live-test
	main.cc)

target_link_libraries (live-test
	tempile)
	
# ============================================================================
