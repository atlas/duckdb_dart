cmake_minimum_required(VERSION 3.24)
project(duckdb_ios C CXX)

set(DUCKDB_FRAMEWORK_EXTENSIONS "icu;parquet;json;autocomplete;core_functions"
    CACHE STRING "Extensions to statically link into the framework")

find_package(Threads REQUIRED)

add_subdirectory(duckdb)

file(READ "${CMAKE_CURRENT_SOURCE_DIR}/../DUCKDB_VERSION" DUCKDB_VERSION_TAG)
string(STRIP "${DUCKDB_VERSION_TAG}" DUCKDB_VERSION_TAG)
string(SUBSTRING "${DUCKDB_VERSION_TAG}" 1 -1 DUCKDB_VERSION_NO_PREFIX)
configure_file(Info.plist.in ${CMAKE_CURRENT_BINARY_DIR}/Info.plist @ONLY)

add_library(duckdb_framework SHARED framework_stub.c
            "${CMAKE_CURRENT_SOURCE_DIR}/duckdb/src/include/duckdb.h")

target_link_libraries(duckdb_framework PRIVATE
  "$<LINK_LIBRARY:WHOLE_ARCHIVE,duckdb_static>"
  duckdb_generated_extension_loader
  Threads::Threads
  ${CMAKE_DL_LIBS})

foreach(ext IN LISTS DUCKDB_FRAMEWORK_EXTENSIONS)
  target_link_libraries(duckdb_framework PRIVATE ${ext}_extension)
endforeach()

set_target_properties(duckdb_framework PROPERTIES
  OUTPUT_NAME "duckdb"
  FRAMEWORK TRUE
  FRAMEWORK_VERSION A
  MACOSX_FRAMEWORK_IDENTIFIER org.duckdb
  MACOSX_FRAMEWORK_INFO_PLIST ${CMAKE_CURRENT_BINARY_DIR}/Info.plist
  PUBLIC_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/duckdb/src/include/duckdb.h"
  VERSION 1.0.0
  SOVERSION 1.0.0)
