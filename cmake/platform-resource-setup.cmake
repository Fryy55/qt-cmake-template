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
    message(STATUS "magick binary found - ${MAGICK_BINARY}")

    set(ICO_PATH ${GEN_PATH}/icon.ico)
    target_include_directories(${PROJECT_NAME} PRIVATE ${GEN_PATH})
    set(PNG_PATH ${CMAKE_CURRENT_SOURCE_DIR}/resources/icon.png)

    add_custom_command(
        OUTPUT ${ICO_PATH}
        COMMAND echo "-- Generating icon.ico"
        COMMAND ${MAGICK_BINARY} ${PNG_PATH} -define icon:auto-resize=16,24,32,48,64,96,128,256 -compress zip ${ICO_PATH}
        COMMAND echo "-- icon.ico generated - ${ICO_PATH}"
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

    configure_file(${PLATFORM_PATH}/template.desktop ${DESKTOP_PATH} @ONLY)

    message(STATUS "${DESKTOP_NAME} generated - ${DESKTOP_PATH}")
elseif (${OS_NAME} STREQUAL macOS)
    find_program(SIPS_BINARY NAMES sips REQUIRED)
    message(STATUS "sips binary found - ${SIPS_BINARY}")
    find_program(ICONUTIL_BINARY NAMES iconutil REQUIRED)
    message(STATUS "iconutil binary found - ${ICONUTIL_BINARY}")

    set(ICNS_PATH ${GEN_PATH}/icon.icns)
    set(PNG_PATH ${CMAKE_CURRENT_SOURCE_DIR}/resources/icon.png)

    add_custom_command(
        OUTPUT ${ICNS_PATH}
        COMMAND bash ${PLATFORM_PATH}/gen-icns.sh ${SIPS_BINARY} ${PNG_PATH} ${GEN_PATH} ${ICONUTIL_BINARY}
        DEPENDS ${PNG_PATH}
        VERBATIM
    )

    set_source_files_properties(${ICNS_PATH} PROPERTIES
        GENERATED TRUE
        MACOSX_PACKAGE_LOCATION "Resources"
    )
    set(MACOSX_BUNDLE_ICON_FILE icon.icns)
    target_sources(${PROJECT_NAME} PRIVATE ${ICNS_PATH})

    message(STATUS ".icns generation set up")


    set(JSON_PATH ${GEN_PATH}/dmg.json)

    configure_file(${PLATFORM_PATH}/template.json ${JSON_PATH} @ONLY)

    message(STATUS "dmg.json generated - ${JSON_PATH}")


    set(GUIDE_PATH "${GEN_PATH}/READ IF YOU HAVE PROBLEMS RUNNING")

    configure_file(${PLATFORM_PATH}/template.guide ${GUIDE_PATH} @ONLY)

    message(STATUS "Guide generated - \"${GUIDE_PATH}\"")
else()
    message(FATAL_ERROR "Platform ${OS_NAME} isn't supported!")
endif()

message(STATUS "Resource setup complete --")