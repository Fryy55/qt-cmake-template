message(STATUS "Setting up Qt --")

find_package(QT NAMES Qt6 Qt5)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets)

set(VERSION_FILE ${CMAKE_CURRENT_SOURCE_DIR}/.github/workflows/qt/VERSION)
if (EXISTS ${VERSION_FILE})
    message(STATUS "Version file found")

    file(READ ${VERSION_FILE} FOUND_VERSION)

    if (${FOUND_VERSION} VERSION_EQUAL ${QT_VERSION})
        message(STATUS "Version matches")
    else()
        message(FATAL_ERROR "Qt version mismatch: expected ${FOUND_VERSION}, using ${QT_VERSION}.\nPlease install the correct version or re-create ${VERSION_FILE}")
    endif()
else()
    message(STATUS "Version file NOT found. Using local Qt version (${QT_VERSION})")

    file(WRITE ${VERSION_FILE} ${QT_VERSION})

    message(STATUS "Version written to ${VERSION_FILE}")
endif()
message(STATUS "Qt version: ${QT_VERSION}")

qt_standard_project_setup()
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

message(STATUS "Qt setup complete --")