import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App 1.0


FocusScope {
    Item {
        id: langPage
        width: appWind.width
        height: appWind.height
        focus: true

        property Item currentFocusedItem

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true

            onWheel: (wheel) => {
                if (wheel.angleDelta.y > 0) {
                    langPage.currentFocusedItem.handleWheelUp()
                } else if (wheel.angleDelta.y < 0) {
                    langPage.currentFocusedItem.handleWheelDown()
                }
            }

            onClicked: (mouse) => {
                if (mouse.button === Qt.MiddleButton) {
                    langPage.currentFocusedItem.handleMiddleClick()
                }
            }
        }


        FontLoader {
            id: headerFont
            source: "../fonts/Font.ttf"
        }

        Column {
            Item {
                id: langHeaderFirst
                width: langPage.width
                height: langPage.height * 0.25

                Text {
                    id: langHeaderFirstText
                    anchors.centerIn: parent
                    text: qsTr("Welcome!")
                    color: ApplicationSettings.screenWhiteColor
                    font.family: headerFont.name
                    font.pixelSize: parent.height * 0.4
                }
            }

            Item {
                id: langHeaderSecond
                width: langPage.width
                height: langPage.height * 0.25

                Text {
                    id: langHeaderSecondText
                    anchors.centerIn: parent
                    text: qsTr("Choose language to proceed")
                    color: ApplicationSettings.screenWhiteColor
                    font.family: headerFont.name
                    font.pixelSize: parent.height * 0.2
                }
            }

            Row {
                spacing: langPage.width * 0.1

                Item {
                    id: enLang
                    width: langPage.width * 0.45
                    height: langPage.height * 0.5

                    Button {
                        id: enLangButton
                        width: parent.width * 0.4
                        height: parent.height * 0.2

                        Text {
                            anchors.centerIn: parent
                            id: enLangButtonText
                            text: qsTr("English")
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.4
                        }

                        anchors.top: parent.top
                        anchors.right: parent.right
                        font.family: headerFont.name
                        font.pixelSize: parent.height

                        background: Rectangle {
                            anchors.fill: parent
                            color: ApplicationSettings.screenBlueHalfTransparentColor
                            radius: width / 2

                            ColorAnimation on color {
                                id: enLangColorAnimEnter
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: enLangColorAnimExit
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }
                        }
                    }

                    onFocusChanged: {
                        if(focus) {
                            enLangColorAnimEnter.start()
                            langPage.currentFocusedItem = enLang 
                        } else {
                            enLangColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        itLang.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        TranslationManager.switchLanguage("en");
                        appStackView.push(startPageTest);
                    }
                    function handleWheelDown() {
                        itLang.forceActiveFocus();
                    }
                }

                Item {
                    id: itLang
                    width: langPage.width * 0.45
                    height: langPage.height * 0.5

                    Button {
                        id: itLangButton
                        width: parent.width * 0.4
                        height: parent.height * 0.2

                        Text {
                            anchors.centerIn: parent
                            id: itLangButtonText
                            text: qsTr("Italian")
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.4
                        }

                        anchors.top: parent.top
                        anchors.left: parent.left
                        font.family: headerFont.name
                        font.pixelSize: parent.height

                        background: Rectangle {
                            anchors.fill: parent
                            color: ApplicationSettings.screenBlueHalfTransparentColor
                            radius: width / 2

                            ColorAnimation on color {
                                id: itLangColorAnimEnter
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: itLangColorAnimExit
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }
                        }
                    }

                    onFocusChanged: {
                        if(focus) {
                            itLangColorAnimEnter.start()
                            langPage.currentFocusedItem = itLang
                        } else {
                            itLangColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        enLang.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        TranslationManager.switchLanguage("it");
                        appStackView.push(startPageTest);
                    }
                    function handleWheelDown() {
                        enLang.forceActiveFocus();
                    }
                }
            }
        }

        Component.onCompleted: {
            enLang.forceActiveFocus();
        }
    }
}

