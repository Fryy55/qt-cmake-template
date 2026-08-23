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

link_to_qt_modules(Widgets Svg) # you can add more modules here as needed

# add CPM libraries as needed
include(cmake/CPM.cmake)

#[[ uncomment to add cavansite (https://github.com/Fryy55/cavansite)
    set(CAVANSITE_ADD_BREEZE all)
    CPMAddPackage("gh:Fryy55/cavansite@1.0.1")

    target_link_libraries(${PROJECT_NAME} PRIVATE cavansite)
]]