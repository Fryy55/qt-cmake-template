cmake_minimum_required(VERSION 3.20)

project(Template VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(cmake/qt-setup.cmake)

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS src/*.cpp)
qt_add_executable(${PROJECT_NAME}
    WIN32
    MACOSX_BUNDLE
    ${SOURCES}

    resources/qresource.qrc
)

include(cmake/platform-resource-setup.cmake)

target_include_directories(${PROJECT_NAME} PRIVATE
    src
)

target_link_libraries(${PROJECT_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin$<0:>
)
