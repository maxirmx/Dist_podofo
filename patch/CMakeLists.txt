# ....................................................................................................
# This is patched file for tests\TokenizerTest
# The strange stuff related to copying files is commented iut - causes problems since by default 
# ${CMAKE_CURRENT_SOURCE_DIR} and ${CMAKE_CURRENT_BINARY_DIR} arethe same
# ....................................................................................................


ADD_EXECUTABLE(TokenizerTest TokenizerTest.cpp)
TARGET_LINK_LIBRARIES(TokenizerTest ${PODOFO_LIB} ${PODOFO_LIB_DEPENDS})
SET_TARGET_PROPERTIES(TokenizerTest PROPERTIES COMPILE_FLAGS "${PODOFO_CFLAGS}")
ADD_DEPENDENCIES(TokenizerTest ${PODOFO_DEPEND_TARGET})

# ....................................................................................................
# Copy the test samples over to the build tree
#ADD_CUSTOM_COMMAND(
#    TARGET TokenizerTest
#    POST_BUILD
#    COMMAND "${CMAKE_COMMAND}" -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/objects" "${CMAKE_CURRENT_BINARY_DIR}/objects"
#    )
# ....................................................................................................
