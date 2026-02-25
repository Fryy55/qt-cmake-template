if (${CMAKE_SYSTEM_NAME} STREQUAL Darwin)
    set(OS_NAME macOS)
else()
    set(OS_NAME ${CMAKE_SYSTEM_NAME})
endif()

string(TOLOWER ${OS_NAME} OS_NAME_LOWERCASE)
set(GEN_PATH ${CMAKE_CURRENT_BINARY_DIR}/platform/${OS_NAME_LOWERCASE})
set(PLATFORM_PATH ${CMAKE_CURRENT_SOURCE_DIR}/resources/platform/${OS_NAME_LOWERCASE})

message(STATUS "Setting up resources for ${OS_NAME} --")
if (${OS_NAME} STREQUAL Windows)
    find_program(MAGICK_BINARY NAMES magick magick.exe REQUIRED)
    message(STATUS "magick binary found")
    message(STATUS "${MAGICK_BINARY}")

    set(ICO_PATH ${GEN_PATH}/icon.ico)
    target_include_directories(${PROJECT_NAME} PRIVATE ${GEN_PATH})
    set(PNG_PATH ${CMAKE_CURRENT_SOURCE_DIR}/resources/icon.png)

    add_custom_command(
        OUTPUT ${ICO_PATH}
        COMMAND echo "-- Generating icon.ico"
        COMMAND ${MAGICK_BINARY} ${PNG_PATH} ${ICO_PATH}
        COMMAND echo "-- icon.ico generated"
        COMMAND echo "-- ${ICO_PATH}"
        DEPENDS ${PNG_PATH}
        VERBATIM
    )

    set(RC_SOURCE ${PLATFORM_PATH}/icon.rc)
    target_sources(${PROJECT_NAME} PRIVATE ${RC_SOURCE})
    set_source_files_properties(${RC_SOURCE} PROPERTIES OBJECT_DEPENDS ${ICO_PATH})

    message(STATUS ".ico generation set up")
elseif (${OS_NAME} STREQUAL Linux)
    set(DESKTOP_NAME ${PROJECT_NAME}.desktop)
    set(DESKTOP_PATH ${GEN_PATH}/${DESKTOP_NAME})
    set(TEMPLATE_PATH ${PLATFORM_PATH}/template.desktop)

    configure_file(${TEMPLATE_PATH} ${DESKTOP_PATH} @ONLY)

    message(STATUS "${DESKTOP_NAME} generated")
    message(STATUS "${DESKTOP_PATH}")
elseif (${OS_NAME} STREQUAL macOS)

else()
    message(FATAL_ERROR "Platform ${OS_NAME} isn't supported!")
endif()

message(STATUS "Resource setup complete --")