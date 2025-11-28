import QtQuick
import QtQuick.Controls
import App 1.0


FocusScope {
    Item {
        id: addinfoPage
        width: appWind.width
        height: appWind.height

        property Item currentFocusedItem

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true

            onWheel: (wheel) => {
                if (wheel.angleDelta.y > 0) {
                    addinfoPage.currentFocusedItem.handleWheelUp()
                } else if (wheel.angleDelta.y < 0) {
                    addinfoPage.currentFocusedItem.handleWheelDown()
                }
            }

            onClicked: (mouse) => {
                if (mouse.button === Qt.MiddleButton) {
                    addinfoPage.currentFocusedItem.handleMiddleClick()
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
                    id: back
                    width: addinfoPage.width / 6
                    height: addinfoPage.height * 0.15

                    Button {
                        id: backButton
                        width: parent.width * 0.8
                        height: parent.height * 0.5

                        Text {
                            anchors.centerIn: parent
                            id: backButtonText
                            text: qsTr("Back")
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
                                id: backColorAnimEnter
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: backColorAnimExit
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }
                        }
                    }

                    onFocusChanged: {
                        if(focus) {
                            backColorAnimEnter.start()
                            addinfoPage.currentFocusedItem = back 
                        } else {
                            backColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                    }
                    function handleMiddleClick() {
                        appStackView.pop();
                    }
                    function handleWheelDown() {
                    }
                }

                Item {
                    width: addinfoPage.width * 2 / 3
                    height: addinfoPage.height * 0.2

                    Text {
                        id: header
                        anchors.centerIn: parent
                        text: "Q-physio Info"
                        color: ApplicationSettings.screenWhiteColor
                        font.family: headerFont.name
                        font.pixelSize: parent.height * 0.4
                    }
                }

                Item {
                    width: addinfoPage.width / 6
                    height: addinfoPage.height * 0.15
                }
            }


            Column {
                Row {
                    spacing: addinfoPage.width * 0.02
                        
                    Item {
                        id: addInfoMBSoftRev
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        Text {
                            id: addInfoMBSoftRevText
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            text: qsTr("MB Software revision:")
                            color: ApplicationSettings.screenWhiteColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                        }
                    }

                    Item {
                        id: addInfoMBSoftRevVal
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        TextField {
                            id: addInfoMBSoftRevValField
                            width: parent.width * 0.6
                            height: parent.height * 0.6
                            anchors.verticalCenter: parent.verticalCenter
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                            text: ApplicationSettings.MBSoftRev

                            background: Rectangle {
                                anchors.fill: parent
                                color: ApplicationSettings.screenWhiteColor
                                radius: width / 2
                            }
                        }
                    }
                }

                Row {
                    spacing: addinfoPage.width * 0.02
                        
                    Item {
                        id: addInfoIOSoftRev
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        Text {
                            id: addInfoIOSoftRevText
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            text: qsTr("I/O Software revision:")
                            color: ApplicationSettings.screenWhiteColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                        }
                    }

                    Item {
                        id: addInfoIOSoftRevVal
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        TextField {
                            id: addInfoIOSoftRevValField
                            width: parent.width * 0.6
                            height: parent.height * 0.6
                            anchors.verticalCenter: parent.verticalCenter
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                            text: ApplicationSettings.IOSoftRev

                            background: Rectangle {
                                anchors.fill: parent
                                color: ApplicationSettings.screenWhiteColor
                                radius: width / 2
                            }
                        }
                    }
                }

                Row {
                    spacing: addinfoPage.width * 0.02
                        
                    Item {
                        id: addInfoMBHardRev
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        Text {
                            id: addInfoMBHardRevText
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            text: qsTr("MB Hardware revision:")
                            color: ApplicationSettings.screenWhiteColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                        }
                    }

                    Item {
                        id: addInfoMBHardRevVal
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        TextField {
                            id: addInfoMBHardRevValField
                            width: parent.width * 0.6
                            height: parent.height * 0.6
                            anchors.verticalCenter: parent.verticalCenter
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                            text: ApplicationSettings.MBHardRev

                            background: Rectangle {
                                anchors.fill: parent
                                color: ApplicationSettings.screenWhiteColor
                                radius: width / 2
                            }
                        }
                    }
                }

                Row {
                    spacing: addinfoPage.width * 0.02
                        
                    Item {
                        id: addInfoIOHardRev
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        Text {
                            id: addInfoIOHardRevText
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            text: qsTr("I/O Hardware revision:")
                            color: ApplicationSettings.screenWhiteColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                        }
                    }

                    Item {
                        id: addInfoIOHardRevVal
                        width: addinfoPage.width * 0.49
                        height: addinfoPage.height * 0.1

                        TextField {
                            id: addInfoIOHardRevValField
                            width: parent.width * 0.6
                            height: parent.height * 0.6
                            anchors.verticalCenter: parent.verticalCenter
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.3
                            text: ApplicationSettings.IOHardRev

                            background: Rectangle {
                                anchors.fill: parent
                                color: ApplicationSettings.screenWhiteColor
                                radius: width / 2
                            }
                        }
                    }
                }
            }

            Row {
                Item {
                    id: start 
                    width: addinfoPage.width
                    height: addinfoPage.height * 0.4

                    Image {
                        anchors.centerIn: parent
                        source: "../icone/QMR_logo.png"
                    }
                }
            }
        }

        Component.onCompleted: {
            back.forceActiveFocus();
            ApplicationSettings.load();
        }
    }
}
