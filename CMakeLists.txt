cmake_minimum_required(VERSION 3.16) # TODO: change cmake version here

project(TemplateODB) # TODO: change project name here

set(CMAKE_CXX_STANDARD 17) # TODO: change c++ version here

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

find_package(ODB REQUIRED COMPONENTS pgsql)

include(${ODB_USE_FILE})

file(GLOB INCLUDE ${PROJECT_SOURCE_DIR}/include/*.h)
file(GLOB SRC ${PROJECT_SOURCE_DIR}/src/*.cpp)
file(GLOB ODB CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR}/include/odb/*.h)

odb_compile(SRC
        FILES ${ODB}
        DB pgsql
        GENERATE_QUERY GENERATE_SESSION GENERATE_SCHEMA
        STANDARD c++17) # TODO: change c++ version here

# copy all odb headers to odb_gen
# because otherwise the generated _odb.h files cant find the original header
file(COPY ${ODB} DESTINATION ${CMAKE_BINARY_DIR}/odb_gen)

add_executable(${PROJECT_NAME}
        ${INCLUDE}
        ${SRC}
        ${ODB})

target_link_libraries(${PROJECT_NAME} ${ODB_LIBRARIES}) # TODO: add libraries here

target_include_directories(${PROJECT_NAME}
        PRIVATE
        ${ODB_INCLUDE_DIRS}
        ${ODB_COMPILE_OUTPUT_DIR})

add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND cp ${CMAKE_BINARY_DIR}/odb_gen/*.sql ${PROJECT_SOURCE_DIR}/sql)