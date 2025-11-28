cmake_minimum_required(VERSION 3.16)

project(qphysio-new VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "/opt/Qt/6.6.0/lib/cmake" ${CMAKE_PREFIX_PATH})

find_package(Qt6 COMPONENTS Quick REQUIRED)

message(STATUS "Qt version: ${Qt6Core_VERSION}")


qt_standard_project_setup(REQUIRES 6.6)

qt_add_executable(qphysio-app
    src/main.cpp
    src/ApplicationSettings.h
    src/ApplicationSettings.cpp
    src/TranslationManager.h
    src/Revisions.json
)


qt_add_qml_module(qphysio-app
    URI QPhysio
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/LangView.qml
        qml/StartView.qml
        qml/ElettrodiView.qml
        qml/ManipoloView.qml
        qml/GuantiView.qml
        qml/InfoView.qml
        qml/AddInfoView.qml


    RESOURCES
        icone/elettrodi_off.png icone/guanti_off.png icone/manipolo_off.png icone/info_off.png
        icone/elettrodi_on.png icone/guanti_on.png icone/manipolo_on.png icone/info_on.png
        icone/QMR_logo.png
        icone/timer.png
        icone/elettrodi_green.png
        icone/elettrodi_red.png
        icone/arrow_white.png

        fonts/Font.ttf
)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(qphysio-app PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.qphysio
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(qphysio-app
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS qphysio-app
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
