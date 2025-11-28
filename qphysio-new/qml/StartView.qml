import QtQuick
import QtQuick.Controls
import App 1.0


FocusScope {
    Item {
        id: startPage
        width: appWind.width
        height: appWind.height

        property Item currentFocusedItem

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true

            onWheel: (wheel) => {
                if (wheel.angleDelta.y > 0) {
                    startPage.currentFocusedItem.handleWheelUp()
                } else if (wheel.angleDelta.y < 0) {
                    startPage.currentFocusedItem.handleWheelDown()
                }
            }

            onClicked: (mouse) => {
                if (mouse.button === Qt.MiddleButton) {
                    startPage.currentFocusedItem.handleMiddleClick()
                }
            }
        }

        FontLoader {
            id: headerFont
            source: "../fonts/Font.ttf"
        }

        Column {
            Row {
                Item {
                    id: lang 
                    width: startPage.width / 6
                    height: startPage.height * 0.15

                    Button {
                        id: langButton
                        width: parent.width * 0.8
                        height: parent.height * 0.5

                        Text {
                            anchors.centerIn: parent
                            id: langButtonText
                            text: qsTr("Lang")
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.4
                        }
                        anchors.centerIn: parent
                        font.family: headerFont.name
                        font.pixelSize: parent.height

                        background: Rectangle {
                            anchors.fill: parent
                            color: ApplicationSettings.screenBlueHalfTransparentColor
                            radius: width / 2

                            ColorAnimation on color {
                                id: langColorAnimEnter
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: langColorAnimExit
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }
                        }
                    }

                    onFocusChanged: {
                        if(focus) {
                            langColorAnimEnter.start()
                            startPage.currentFocusedItem = lang
                        } else {
                            langColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        info.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        appStackView.pop();
                    }
                    function handleWheelDown() {
                        elettrodi.forceActiveFocus();
                    }
                }

                Item {
                    width: startPage.width * 2 / 3
                    height: startPage.height * 0.15

                    Text {
                        id: header
                        anchors.centerIn: parent
                        text: "Q-physio"
                        color: ApplicationSettings.screenWhiteColor
                        font.family: headerFont.name
                        font.pixelSize: parent.height * 0.4
                    }
                }

                Item {
                    width: startPage.width / 6
                    height: startPage.height * 0.15
                }
            }

            Row {
                Item {
                    id: elettrodi
                    width: startPage.width / 3
                    height: startPage.height * 0.5

                    Image {
                        id: elettrodiImg
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        source: "../icone/elettrodi_on.png"
                        opacity: 0.5
                    }


                    ParallelAnimation {
                        id: animEnterElettrodi
                        NumberAnimation { target: elettrodiImg; property: "opacity"; to: 1.0; duration: 200 }
                    }

                    ParallelAnimation {
                        id: animExitElettrodi
                        NumberAnimation { target: elettrodiImg; property: "opacity"; to: 0.5; duration: 200 }
                    }

                    onFocusChanged: {
                        if(focus) {
                            animEnterElettrodi.start()
                            startPage.currentFocusedItem = elettrodi 
                        } else {
                            animExitElettrodi.start()
                        }
                    }

                    function handleWheelUp() {
                        lang.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        appStackView.push(elettrodiPageTest);
                    }
                    function handleWheelDown() {
                        manipolo.forceActiveFocus();
                    }
                }

                Item {
                    id: manipolo
                    width: startPage.width / 3
                    height: startPage.height * 0.5
                    
                    Image {
                        id: manipoloImg
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        opacity: 1.0
                        source: "../icone/manipolo_on.png"
                    }

                    ParallelAnimation {
                        id: animEnterManipolo
                        NumberAnimation { target: manipoloImg; property: "opacity"; to: 1.0; duration: 200 }
                    }

                    ParallelAnimation {
                        id: animExitManipolo
                        NumberAnimation { target: manipoloImg; property: "opacity"; to: 0.5; duration: 200 }
                    }

                    onFocusChanged: {
                        if(focus) {
                            animEnterManipolo.start()
                            startPage.currentFocusedItem = manipolo 
                        } else {
                            animExitManipolo.start()
                        }
                    }

                    function handleWheelUp() {
                        elettrodi.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        appStackView.push(manipoloPageTest);
                    }
                    function handleWheelDown() {
                        guanti.forceActiveFocus();
                    }
                }
                

                Item {
                    id: guanti
                    width: startPage.width / 3
                    height: startPage.height * 0.5

                    Image {
                        id: guantiImg
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        opacity: 0.5
                        source: "../icone/guanti_on.png"
                    }

                    ParallelAnimation {
                        id: animEnterGuanti
                        NumberAnimation { target: guantiImg; property: "opacity"; to: 1.0; duration: 200 }
                    }

                    ParallelAnimation {
                        id: animExitGuanti
                        NumberAnimation { target: guantiImg; property: "opacity"; to: 0.5; duration: 200 }
                    }

                    onFocusChanged: {
                        if(focus) {
                            animEnterGuanti.start()
                            startPage.currentFocusedItem = guanti 
                        } else {
                            animExitGuanti.start()
                        }
                    }

                    function handleWheelUp() {
                        manipolo.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        appStackView.push(guantiPageTest);
                    }
                    function handleWheelDown() {
                        info.forceActiveFocus();
                    }
                }
            }

            Row {
                Item {
                    width: startPage.width / 3
                    height: startPage.height * 0.25
                }

                Item {
                    width: startPage.width / 3
                    height: startPage.height * 0.25
                    Image {
                        anchors.centerIn: parent
                        source: "../icone/QMR_logo.png"
                    }
                }

                Item {
                    id: info
                    width: startPage.width / 3
                    height: startPage.height * 0.3

                    Image {
                        id: infoImg
                        anchors.centerIn: parent
                        anchors.right: parent.right
                        source: "../icone/info_on.png"
                        opacity: 0.5
                    }


                    ParallelAnimation {
                        id: animEnterInfo
                        NumberAnimation { target: infoImg; property: "opacity"; to: 1.0; duration: 200 }
                    }

                    ParallelAnimation {
                        id: animExitInfo
                        NumberAnimation { target: infoImg; property: "opacity"; to: 0.5; duration: 200 }
                    }

                    onFocusChanged: {
                        if(focus) {
                            animEnterInfo.start()
                            startPage.currentFocusedItem = info 
                        } else {
                            animExitInfo.start()
                        }
                    }

                    function handleWheelUp() {
                        guanti.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        appStackView.push(infoPageTest);
                    }
                    function handleWheelDown() {
                        lang.forceActiveFocus();
                    }
                }
            }
        }

        Component.onCompleted: {
            ApplicationSettings.load();
            manipolo.forceActiveFocus();
        }
    }
}
