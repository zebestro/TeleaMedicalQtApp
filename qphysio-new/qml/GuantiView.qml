import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import App 1.0


FocusScope {
    Item {
        id: guantiPage
        width: appWind.width
        height: appWind.height
        focus: true

        property int timeCounterInSec: 0
        property Item currentFocusedItem

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true

            onWheel: (wheel) => {
                if (wheel.angleDelta.y > 0) {
                    guantiPage.currentFocusedItem.handleWheelUp()
                } else if (wheel.angleDelta.y < 0) {
                    guantiPage.currentFocusedItem.handleWheelDown()
                }
            }

            onClicked: (mouse) => {
                if (mouse.button === Qt.MiddleButton) {
                    guantiPage.currentFocusedItem.handleMiddleClick()
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
                    width: guantiPage.width / 6
                    height: guantiPage.height * 0.15

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
                            guantiPage.currentFocusedItem = back
                        } else {
                            backColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        guantiTotalTime.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        if (!timer.running) {
                            appStackView.pop();
                        }
                    }
                    function handleWheelDown() {
                        guantiPower.forceActiveFocus();
                    }
                }

                Item {
                    width: guantiPage.width * 2 / 3
                    height: guantiPage.height * 0.15

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
                    width: guantiPage.width / 6
                    height: guantiPage.height * 0.15
                }
            }



            Row {
                Item {
                    id: guantiTotalTime
                    width: guantiPage.width / 4
                    height: guantiPage.height * 0.7 

                    property bool entered: false
                    property int timeInMin: 1

                    Rectangle {
                        id: guantiTotalTimeBackRect
                        anchors.fill: parent
                        anchors.margins: width * 0.1
                        color: ApplicationSettings.screenBlueColor
                        border.color: ApplicationSettings.screenWhiteColor
                        border.width: 2
                        radius: width * 0.1 

                        Image {
                            id: guantiTotalTimeImg
                            width: guantiPage.width / 8
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter 
                            anchors.bottom: guantiTotalTimeText.top
                            //anchors.right: parent.right
                            source: "../icone/timer.png"
                        }

                        Text {
                            id: guantiTotalTimeText
                            text: qsTr("Total time")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.verticalCenter
                            color: ApplicationSettings.screenWhiteColor
                            font.pixelSize: 20
                            font.bold: true

                        }


                        Text {
                            id: guantiTotalTimeValText
                            text: guantiTotalTime.timeInMin 
                            color: ApplicationSettings.screenWhiteColor
                            font.pixelSize: 60
                            font.bold: true
                            anchors.top: parent.verticalCenter
                            anchors.right: parent.horizontalCenter

                        }

                        Text {
                            text: " min"
                            color: ApplicationSettings.screenWhiteColor
                            font.pixelSize: 20
                            font.bold: true
                            anchors.left: parent.horizontalCenter
                            anchors.verticalCenter: guantiTotalTimeValText.verticalCenter
                        }

                        ColorAnimation on border.color {
                            id: borderAnimEnter
                            from: ApplicationSettings.screenBlueColor
                            to: ApplicationSettings.screenWhiteColor
                            duration: 100
                            running: false
                        }

                        ColorAnimation on border.color {
                            id: borderAnimExit
                            from: ApplicationSettings.screenWhiteColor
                            to: ApplicationSettings.screenBlueColor
                            duration: 100
                            running: false
                        }


                        ColorAnimation on color {
                            id: colorAnimEnter
                            from: ApplicationSettings.screenBlueColor
                            to: ApplicationSettings.screenBlueHalfTransparentColor
                            duration: 200
                            running: false
                        }

                        ColorAnimation on color {
                            id: colorAnimExit
                            from: ApplicationSettings.screenBlueHalfTransparentColor
                            to: ApplicationSettings.screenBlueColor
                            duration: 200
                            running: false
                        }
                    }
                    
                    onFocusChanged: {
                        if(focus) {
                            borderAnimEnter.start()
                            guantiPage.currentFocusedItem = guantiTotalTime
                        } else {
                            borderAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        if (entered) {
                            if (guantiTotalTime.timeInMin > 0)
                                guantiTotalTime.timeInMin--;
                                guantiDial.totalSeconds = guantiTotalTime.timeInMin * 60;
                                guantiDial.remainingSeconds = guantiTotalTime.timeInMin * 60;
                        } else {
                            start.forceActiveFocus();
                        }
                    }
                    function handleMiddleClick() {
                        entered = entered ? false : true
                        entered ? colorAnimEnter.start() : colorAnimExit.start()
                    }
                    function handleWheelDown() {
                        if (entered) {
                            if (guantiTotalTime.timeInMin < 60) {
                                guantiTotalTime.timeInMin++;
                                guantiDial.totalSeconds = guantiTotalTime.timeInMin * 60;
                                guantiDial.remainingSeconds = guantiTotalTime.timeInMin * 60;
                            }

                        } else {
                            back.forceActiveFocus();
                        }
                    }
                }

                
                Item {
                    id: guantiDial
                    width: guantiPage.width / 2
                    height: guantiPage.height * 0.7 

                    property int totalSeconds: guantiTotalTime.timeInMin * 60
                    property int remainingSeconds: totalSeconds

                    Timer {
                        id: timer
                        interval: 1000
                        repeat: true
                        running: false
                        onTriggered: {
                            if (parent.remainingSeconds > 0) {
                                guantiDial.remainingSeconds--;
                            } else {
                                timer.stop();
                                // There you can add something you need to do when timer expired
                                startButton.checked = true;
                                startButtonText.text = qsTr("START");
                                guantiDial.totalSeconds = guantiTotalTime.timeInMin * 60;
                                guantiDial.remainingSeconds = guantiTotalTime.timeInMin * 60;
                                ApplicationSettings.totalTimeInSec += guantiPage.timeCounterInSec;
                                ApplicationSettings.save();
                                guantiPage.timeCounterInSec = 0;

                            }

                            guantiPage.timeCounterInSec += 1;
                        }
                    }

                    Dial {
                        id: dial
                        from: 0
                        to: parent.totalSeconds
                        value: parent.remainingSeconds
                        anchors.centerIn: parent
                        height: parent.height
                        width: height
                        startAngle: 180
                        endAngle: 540
                        enabled: false

                        background: Shape {
                            anchors.fill: parent
                            antialiasing: true
                            layer.enabled: true
                            layer.samples: 8

                            ShapePath {
                                id: shp
                                strokeWidth: 6
                                strokeColor: "white"
                                fillColor: "transparent"

                                PathAngleArc {
                                    centerX: parent.x + dial.width / 2
                                    centerY: parent.y + dial.height / 2
                                    radiusX: dial.width / 2 - 10
                                    radiusY: dial.height / 2 - 10
                                    startAngle: 90
                                    sweepAngle: dial.angle - 180
                                }
                            }
                        }

                        handle: Rectangle {
                            id: handler
                            width: 10
                            height: dial.height * 0.8
                            radius: 5
                            color: "transparent"
                            antialiasing: true

                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter


                            Image {
                                id: arr
                                source: "../icone/arrow_white.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                            }


                            transform: Rotation {
                                origin.x: handler.width / 2
                                origin.y: handler.height / 2
                                angle: dial.angle + 180
                            }

                            y: parent.height / 2 - height
                        }

                        Behavior on value {
                            NumberAnimation {
                                duration: 1000
                                easing.type: Easing.Linear
                            }
                        }
                    }

                    Text {
                        id: timeTextString
                        anchors.horizontalCenter: dial.horizontalCenter
                        anchors.bottom: timeText.top
                        color: ApplicationSettings.screenWhiteColor
                        font.pixelSize: 36
                        font.bold: true
                        text: qsTr("Time")
                    }


                    Text {
                        id: timeText
                        anchors.centerIn: dial
                        color: ApplicationSettings.screenWhiteColor
                        font.pixelSize: 60
                        font.bold: true
                        text: {
                            var m = Math.floor(parent.remainingSeconds / 60)
                            var s = parent.remainingSeconds % 60
                            var mm = m < 10 ? "0" + m : m
                            var ss = s < 10 ? "0" + s : s
                            return mm + ":" + ss
                        }
                    }


                    Component.onCompleted: {
                        guantiTotalTime.forceActiveFocus();
                    }
                }

                Item {
                    id: guantiPower
                    width: guantiPage.width / 4
                    height: guantiPage.height * 0.7 


                    property bool entered: false
                    property int power: 0

                    Rectangle {
                        id: guantiPowerBackRect
                        anchors.fill: parent
                        anchors.margins: width * 0.1
                        color: ApplicationSettings.screenBlueColor
                        border.color: ApplicationSettings.screenBlueColor
                        border.width: 2
                        radius: width * 0.1 

                        Image {
                            id: guantiPowerImg
                            width: guantiPage.width / 8
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter 
                            anchors.bottom: guantiPowerText.top
                            //anchors.right: parent.right
                            source: "../icone/guanti_on.png"
                        }

                        Text {
                            id: guantiPowerText
                            text: qsTr("Power")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.verticalCenter
                            color: ApplicationSettings.screenWhiteColor
                            font.pixelSize: 20
                            font.bold: true

                        }

                        Text {
                            id: guantiPowerValText
                            text: guantiPower.power 
                            color: ApplicationSettings.screenWhiteColor
                            font.pixelSize: 60
                            font.bold: true
                            anchors.top: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter

                        }

                        ColorAnimation on border.color {
                            id: borderAnimEnterPower
                            from: ApplicationSettings.screenBlueColor
                            to: ApplicationSettings.screenWhiteColor
                            duration: 100
                            running: false
                        }

                        ColorAnimation on border.color {
                            id: borderAnimExitPower
                            from: ApplicationSettings.screenWhiteColor
                            to: ApplicationSettings.screenBlueColor
                            duration: 100
                            running: false
                        }


                        ColorAnimation on color {
                            id: colorAnimEnterPower
                            from: ApplicationSettings.screenBlueColor
                            to: ApplicationSettings.screenBlueHalfTransparentColor
                            duration: 200
                            running: false
                        }

                        ColorAnimation on color {
                            id: colorAnimExitPower
                            from: ApplicationSettings.screenBlueHalfTransparentColor
                            to: ApplicationSettings.screenBlueColor
                            duration: 200
                            running: false
                        }
                    }
                    
                    onFocusChanged: {
                        if(focus) {
                            borderAnimEnterPower.start()
                            guantiPage.currentFocusedItem = guantiPower
                        } else {
                            borderAnimExitPower.start()
                        }
                    }

                    function handleWheelUp() {
                        if (entered) {
                            if (guantiPower.power > 0)
                                guantiPower.power -= 5;
                        } else {
                            back.forceActiveFocus();
                        }
                    }
                    function handleMiddleClick() {
                        entered = entered ? false : true
                        entered ? colorAnimEnterPower.start() : colorAnimExitPower.start()
                    }
                    function handleWheelDown() {
                        if (entered) {
                            if (guantiPower.power < 60) {
                                guantiPower.power += 5;
                            }

                        } else {
                            start.forceActiveFocus();
                        }
                    }
                }
            }

            Row {
                Item {
                    id: start 
                    width: guantiPage.width
                    height: guantiPage.height * 0.15

                    Button {
                        id: startButton
                        width: parent.width * 0.2
                        height: parent.height * 0.5

                        Text {
                            anchors.centerIn: parent
                            id: startButtonText
                            text: qsTr("START")
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.5
                        }
                        checkable: true
                        checked: true
                        anchors.centerIn: parent
                        font.family: headerFont.name
                        font.pixelSize: parent.height * 0.4

                        background: Rectangle {
                            anchors.fill: parent
                            color: ApplicationSettings.screenBlueHalfTransparentColor
                            radius: width / 2

                            ColorAnimation on color {
                                id: startColorAnimEnter
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: startColorAnimExit
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }
                        }
                    }

                    onFocusChanged: {
                        if(focus) {
                            startColorAnimEnter.start()
                            guantiPage.currentFocusedItem = start
                        } else {
                            startColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        guantiPower.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        if (startButton.checked) {
                            startButton.checked = false;
                            startButtonText.text = qsTr("STOP");
                            timer.start();

                        } else {
                            startButton.checked = true;
                            startButtonText.text = qsTr("START");
                            timer.stop();
                            ApplicationSettings.totalTimeInSec += guantiPage.timeCounterInSec;
                            ApplicationSettings.save();
                            guantiPage.timeCounterInSec = 0;
                        }
                    }
                    function handleWheelDown() {
                        guantiTotalTime.forceActiveFocus();
                    }
                }
            }
        }

        Component.onCompleted: {
            ApplicationSettings.load();
        }
    }
}
