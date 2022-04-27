cmake_minimum_required(VERSION 3.16)
project(TemplateODB)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -Wall")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pthread")

include(FindODB.cmake)

file(GLOB OdbCMake_ODB_HEADERS CONFIGURE_DEPENDS
        ${PROJECT_SOURCE_DIR}/odb/*.h)

file(GLOB OdbCMake_ODB_INCLUDES CONFIGURE_DEPENDS
        ${PROJECT_SOURCE_DIR}/odb/*.hxx)

odb_compile(
        GENERATE_QUERY GENERATE_SESSION GENERATE_SCHEMA
        DB pgsql STANDARD c++17
        HEADER ${OdbCMake_ODB_HEADERS}
        INCLUDE ${OdbCMake_ODB_INCLUDES}
        DEFAULT_POINTER std::shared_ptr)

add_executable(${PROJECT_NAME} main.cpp
        odb/Person.h
        ${OdbCMake_SOURCES} ${OdbCMake_ODB_HEADERS})

target_link_libraries(${PROJECT_NAME} odb-pgsql odb pqxx pq)