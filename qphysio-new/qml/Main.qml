import QtQuick
import QtQuick.Controls.Basic
import App


ApplicationWindow {
    id: appWind
    title: "TeleaMedical App"

    width: ApplicationSettings.screenWidth
    height: ApplicationSettings.screenHeight

    background: Rectangle {
        anchors.fill: parent
        color: ApplicationSettings.screenBlueColor
    }

    // minimumWidth: 1024
    // minimumHeight: 600
    minimumWidth: ApplicationSettings.screenWidth
    minimumHeight: ApplicationSettings.screenHeight

    visible: true

    // visibility: "FullScreen"      // enable to run fullscreen when embedded

    // property string bg_color: "#1a91ff"
    // color: bg_color

    // // Pre-load qml files for the different screen-views
    // // taking care to use the same id names, so that they can recall each-others
    // // (the editor complains about definitions but it will run fine)
    // Mainmenu {id: menu}

    // Elettrodi {id: screen_elettrodi}
    // Manipolo {id: screen_manipolo}
    // Guanti {id: screen_guanti}

    LangView {
        id: langPageTest
        visible: false
    }

    StartView {
        id: startPageTest
        visible: false
    }

    ElettrodiView {
        id: elettrodiPageTest
        visible: false
    }

    ManipoloView {
        id: manipoloPageTest
        visible: false
    }

    GuantiView {
        id: guantiPageTest
        visible: false
    }

    InfoView {
        id: infoPageTest
        visible: false
    }

    AddInfoView {
        id: addInfoPageTest
        visible: false
    }

    StackView {
        id: appStackView
        anchors.fill: parent

        /*
        pushEnter: Transition {
        }

        pushExit: Transition {
        }

        popEnter: Transition {
        }

        popExit: Transition {
        }
        */
    }

    Component.onCompleted: {
        ApplicationSettings.load();
        appStackView.push(langPageTest)
    }
}
