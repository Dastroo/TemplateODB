cmake_minimum_required(VERSION 3.17)
project(Genodb)

set(CMAKE_CXX_STANDARD 17)

include_directories(include external include/types)

MACRO(ODB_GENERATE header table grantsequence)
    file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/include/types/gen)
    #    SET(cxxFile "${CMAKE_SOURCE_DIR}/include/types/gen/${header}-odb.cpp")
    #    SET(hxxFile "${CMAKE_SOURCE_DIR}/include/types/gen/${header}-odb.h")
    #    SET(ixxFile "${CMAKE_SOURCE_DIR}/include/types/gen/${header}-odb.i")
    SET(cxxFile "${CMAKE_SOURCE_DIR}/include/types/gen/${header}.cpp")
    SET(hxxFile "${CMAKE_SOURCE_DIR}/include/types/gen/${header}.h")
    SET(ixxFile "${CMAKE_SOURCE_DIR}/include/types/gen/${header}.i")
    SET(sqlFile "${CMAKE_SOURCE_DIR}/include/types/gen/${header}.sql")

    SET(ODB_GENERATED_FILES "${cxxFile} ${hxxFile} ${ixxFile} ${sqlFile}")
    #    SET(ODB_GENERATED_FILES ${cxxFile} ${hxxFile} ${ixxFile} ${sqlFile})

    ADD_CUSTOM_COMMAND(
            OUTPUT ${ODB_GENERATED_FILES}
            COMMAND odb -o ${CMAKE_SOURCE_DIR}/include/types/gen/
            -I${CMAKE_SOURCE_DIR}/include --cxx-suffix .cpp --hxx-suffix .h --ixx-suffix .ipp
            --std c++17 -d pgsql --generate-query --generate-schema
            --sql-name-case lower
            --sql-epilogue 'GRANT ALL ON TABLE ${table} TO roleaureora\; ${grantsequence}\;'
            --default-pointer std::shared_ptr
            --show-sloc ${CMAKE_SOURCE_DIR}/include/types/${header}.h
            DEPENDS ${CMAKE_SOURCE_DIR}/include/types/${header}.h
            COMMENT "Generate database support code for ${header}.h")

    #    ADD_CUSTOM_TARGET(RunGenerator-${header} DEPENDS ${ODB_GENERATED_FILES}
    #            COMMENT "Checking if re-generation is required for ${header}.h")

    ADD_CUSTOM_TARGET(RunGenerator-${header} DEPENDS ${ODB_GENERATED_FILES}
            COMMENT "Checking if re-generation is required for ${header}.h")

    #ADD_DEPENDENCIES(${CMAKE_PROJECT_NAME} RunGenerator-${header})
ENDMACRO()

#target_include_directories(rest_aureora PRIVATE ${YOUR_DIRECTORY})
#target_include_directories(rest_aureora PRIVATE include external)

#add_custom_command(rest_aureora DEPENDS RunGenerator-Account)


#target_include_directories(rest_aureora RunGenerator-Account)

#target_link_libraries(rest_aureora cpprest jsoncpp spdlog pthread crypto ssl bcrypt fmt strutils odb-pgsql odb pqxx pq)

#add_subdirectory(Google_tests)

ODB_GENERATE(Account accounts "'GRANT ALL ON SEQUENCE accounts_id_seq TO roleaureora'")
ODB_GENERATE(RegisteringAccount registeringaccounts "")