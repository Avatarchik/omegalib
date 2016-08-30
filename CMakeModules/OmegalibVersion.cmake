# Find the current branch
execute_process(
  COMMAND git rev-parse --abbrev-ref HEAD
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE GIT_BRANCH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

file(STRINGS ${CMAKE_SOURCE_DIR}/include/version.h
    OMEGALIB_VERSION_MAJOR
    REGEX "^#define OMEGA_VERSION_MAJOR.*")

file(STRINGS ${CMAKE_SOURCE_DIR}/include/version.h
    OMEGALIB_VERSION_MINOR
    REGEX "^#define OMEGA_VERSION_MINOR.*")

file(STRINGS ${CMAKE_SOURCE_DIR}/include/version.h
    OMEGALIB_VERSION_REVISION
    REGEX "^#define OMEGA_VERSION_REVISION.*")
    
string(REGEX MATCH "[0-9]+" OMEGALIB_VERSION_MAJOR ${OMEGALIB_VERSION_MAJOR})
string(REGEX MATCH "[0-9]+" OMEGALIB_VERSION_MINOR ${OMEGALIB_VERSION_MINOR})
string(REGEX MATCH "[0-9]+" OMEGALIB_VERSION_REVISION ${OMEGALIB_VERSION_REVISION})

if(${OMEGALIB_VERSION_REVISION} GREATER 0)
    set(OMEGALIB_VERSION ${OMEGALIB_VERSION_MAJOR}.${OMEGALIB_VERSION_MINOR}.${OMEGALIB_VERSION_REVISION})
else()
    set(OMEGALIB_VERSION ${OMEGALIB_VERSION_MAJOR}.${OMEGALIB_VERSION_MINOR})
endif()

message("Omegalib version identified: ${OMEGALIB_VERSION} - ${GIT_BRANCH}")