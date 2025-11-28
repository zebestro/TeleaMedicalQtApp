import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import App 1.0


FocusScope {
    Item {
        id: elettrodiPage
        width: appWind.width
        height: appWind.height

        property int timeCounterInSec: 0
        property Item currentFocusedItem

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true

            onWheel: (wheel) => {
                if (wheel.angleDelta.y > 0) {
                    elettrodiPage.currentFocusedItem.handleWheelUp()
                } else if (wheel.angleDelta.y < 0) {
                    elettrodiPage.currentFocusedItem.handleWheelDown()
                }
            }

            onClicked: (mouse) => {
                if (mouse.button === Qt.MiddleButton) {
                    elettrodiPage.currentFocusedItem.handleMiddleClick()
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
                    width: elettrodiPage.width / 6
                    height: elettrodiPage.height * 0.15

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
                            elettrodiPage.currentFocusedItem = back 
                        } else {
                            backColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        elettrodiTotalTime.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        if (!timer.running) {
                            appStackView.pop();
                        }
                    }
                    function handleWheelDown() {
                        elettrodiPowerFirst.forceActiveFocus();
                    }
                }

                Item {
                    width: elettrodiPage.width * 2 / 3
                    height: elettrodiPage.height * 0.15

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
                    width: elettrodiPage.width / 6
                    height: elettrodiPage.height * 0.15
                }
            }



            Row {
                Column {
                    Item {
                        id: elettrodiTotalTime
                        width: elettrodiPage.width / 4
                        height: elettrodiPage.height * 0.35

                        property bool entered: false
                        property int timeInMin: 1

                        Rectangle {
                            id: elettrodiTotalTimeBackRect
                            anchors.fill: parent
                            anchors.bottomMargin: parent.width * 0.05
                            anchors.leftMargin: parent.width * 0.1
                            anchors.rightMargin: parent.width * 0.1
                            color: ApplicationSettings.screenBlueColor
                            border.color: ApplicationSettings.screenWhiteColor
                            border.width: 2
                            radius: width * 0.1 

                            Image {
                                id: elettrodiTotalTimeImg
                                width: elettrodiPage.width / 16
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter 
                                anchors.bottom: elettrodiTotalTimeText.top
                                source: "../icone/timer.png"
                            }

                            Text {
                                id: elettrodiTotalTimeText
                                text: qsTr("Total time")
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.verticalCenter
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 20
                                font.bold: true

                            }


                            Text {
                                id: elettrodiTotalTimeValText
                                text: elettrodiTotalTime.timeInMin 
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
                                anchors.verticalCenter: elettrodiTotalTimeValText.verticalCenter
                            }

                            ColorAnimation on border.color {
                                id: borderAnimEnterTotalTime
                                from: ApplicationSettings.screenBlueColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 100
                                running: false
                            }

                            ColorAnimation on border.color {
                                id: borderAnimExitTotalTime
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueColor
                                duration: 100
                                running: false
                            }


                            ColorAnimation on color {
                                id: colorAnimEnterTotalTime
                                from: ApplicationSettings.screenBlueColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: colorAnimExitTotalTime
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenBlueColor
                                duration: 200
                                running: false
                            }
                        }

                        onFocusChanged: {
                            if(focus) {
                                borderAnimEnterTotalTime.start()
                                elettrodiPage.currentFocusedItem = elettrodiTotalTime 
                            } else {
                                borderAnimExitTotalTime.start()
                            }
                        }

                        function handleWheelUp() {
                            if (entered) {
                                if (elettrodiTotalTime.timeInMin > 0)
                                    elettrodiTotalTime.timeInMin--;
                                    elettrodiDial.totalSeconds = elettrodiTotalTime.timeInMin * 60;
                                    elettrodiDial.remainingSeconds = elettrodiTotalTime.timeInMin * 60;
                            } else {
                                elettrodiSwapTime.forceActiveFocus();
                            }
                        }
                        function handleMiddleClick() {
                            entered = entered ? false : true
                            entered ? colorAnimEnterTotalTime.start() : colorAnimExitTotalTime.start()
                        }
                        function handleWheelDown() {
                            if (entered) {
                                if (elettrodiTotalTime.timeInMin < 60) {
                                    elettrodiTotalTime.timeInMin++;
                                    elettrodiDial.totalSeconds = elettrodiTotalTime.timeInMin * 60;
                                    elettrodiDial.remainingSeconds = elettrodiTotalTime.timeInMin * 60;
                                }

                            } else {
                                back.forceActiveFocus();
                            }
                        }
                    }

                    Item {
                        id: elettrodiSwapTime
                        width: elettrodiPage.width / 4
                        height: elettrodiPage.height * 0.35

                        property bool entered: false
                        property int timeInSec: 30
                        property bool isFirst: true


                        Rectangle {
                            id: elettrodiSwapTimeBackRect
                            anchors.fill: parent
                            anchors.topMargin: parent.width * 0.05
                            anchors.leftMargin: parent.width * 0.1
                            anchors.rightMargin: parent.width * 0.1
                            color: ApplicationSettings.screenBlueColor
                            border.color: ApplicationSettings.screenBlueColor
                            border.width: 2
                            radius: width * 0.1 

                            Image {
                                id: elettrodiSwapTimeImg
                                width: elettrodiPage.width / 16
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter 
                                anchors.bottom: elettrodiSwapTimeText.top
                                //anchors.right: parent.right
                                source: "../icone/timer.png"
                            }

                            Text {
                                id: elettrodiSwapTimeText
                                text: qsTr("Swap Time")
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.verticalCenter
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 20
                                font.bold: true

                            }


                            Text {
                                id: elettrodiSwapTimeValText
                                text: elettrodiSwapTime.timeInSec
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 60
                                font.bold: true
                                anchors.top: parent.verticalCenter
                                anchors.right: parent.horizontalCenter

                            }

                            Text {
                                text: " sec"
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 20
                                font.bold: true
                                anchors.left: parent.horizontalCenter
                                anchors.verticalCenter: elettrodiSwapTimeValText.verticalCenter
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
                                elettrodiPage.currentFocusedItem = elettrodiSwapTime
                            } else {
                                borderAnimExit.start()
                            }
                        }

                        function handleWheelUp() {
                            if (entered) {
                                if (elettrodiSwapTime.timeInSec > 0)
                                    elettrodiSwapTime.timeInSec--;
                                    elettrodiDial.totalSwapSeconds = elettrodiSwapTime.timeInSec;
                                    elettrodiDial.remainingSwapSeconds = elettrodiSwapTime.timeInSec;
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
                                if (elettrodiSwapTime.timeInSec < 30) {
                                    elettrodiSwapTime.timeInSec++;
                                    elettrodiDial.totalSwapSeconds = elettrodiSwapTime.timeInSec;
                                    elettrodiDial.remainingSwapSeconds = elettrodiSwapTime.timeInSec;
                                }

                            } else {
                                elettrodiTotalTime.forceActiveFocus();
                            }
                        }
                    }
                }

                
                Item {
                    id: elettrodiDial
                    width: elettrodiPage.width / 2
                    height: elettrodiPage.height * 0.7 

                    property int totalSeconds: elettrodiTotalTime.timeInMin * 60
                    property int remainingSeconds: totalSeconds

                    property int totalSwapSeconds: elettrodiSwapTime.timeInSec
                    property int remainingSwapSeconds: totalSwapSeconds

                    Timer {
                        id: timer
                        interval: 1000
                        repeat: true
                        running: false
                        onTriggered: {
                            if (parent.remainingSeconds > 0) {
                                elettrodiDial.remainingSeconds--;

                                if (parent.remainingSwapSeconds > 1) {
                                    parent.remainingSwapSeconds--;
                                } else {
                                    parent.remainingSwapSeconds = parent.totalSwapSeconds;
                                    if (elettrodiSwapTime.isFirst) {
                                        swapTimeValText.color = "#ff0000"
                                        elettrodiSwapTime.isFirst = false
                                    } else {
                                        swapTimeValText.color = "#00ff00"
                                        elettrodiSwapTime.isFirst = true
                                    }
                                }

                            } else {
                                timer.stop();
                                // There you can add something you need to do when timer expired
                                startButton.checked = true;
                                startButtonText.text = qsTr("START");
                                elettrodiDial.totalSeconds = elettrodiTotalTime.timeInMin * 60;
                                elettrodiDial.remainingSeconds = elettrodiTotalTime.timeInMin * 60;
                                swapTimeValText.color = "#00ff00"
                                elettrodiSwapTime.isFirst = true
                                parent.remainingSwapSeconds = parent.totalSwapSeconds;
                                ApplicationSettings.totalTimeInSec += elettrodiPage.timeCounterInSec;
                                ApplicationSettings.save();
                                elettrodiPage.timeCounterInSec = 0;

                            }

                            elettrodiPage.timeCounterInSec += 1;

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
                        id: totalTimeText
                        anchors.horizontalCenter: dial.horizontalCenter
                        anchors.bottom: totalTimeValText.top
                        color: ApplicationSettings.screenWhiteColor
                        font.pixelSize: 36
                        font.bold: true
                        text: qsTr("Time")
                    }

                    Text {
                        id: totalTimeValText
                        // anchors.centerIn: dial
                        anchors.bottom: dial.verticalCenter
                        anchors.horizontalCenter: dial.horizontalCenter
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

                    Text {
                        id: swapTimeText
                        anchors.top: dial.verticalCenter
                        anchors.horizontalCenter: dial.horizontalCenter
                        color: ApplicationSettings.screenWhiteColor
                        font.pixelSize: 36
                        font.bold: true
                        text: qsTr("Swap Time")
                    }

                    Text {
                        id: swapTimeValText
                        anchors.horizontalCenter: dial.horizontalCenter
                        anchors.top: swapTimeText.bottom
                        color: "#00ff00"
                        font.pixelSize: 60
                        font.bold: true
                        text: parent.remainingSwapSeconds
                    }


                    Component.onCompleted: {
                        elettrodiTotalTime.forceActiveFocus();
                    }
                }

                Column {
                    Item {
                        id: elettrodiPowerFirst
                        width: elettrodiPage.width / 4
                        height: elettrodiPage.height * 0.35


                        property bool entered: false
                        property int power: 0

                        Rectangle {
                            id: elettrodiPowerFirstBackRect
                            anchors.fill: parent
                            anchors.bottomMargin: parent.width * 0.05
                            anchors.leftMargin: parent.width * 0.1
                            anchors.rightMargin: parent.width * 0.1
                            color: ApplicationSettings.screenBlueColor
                            border.color: ApplicationSettings.screenBlueColor
                            border.width: 2
                            radius: width * 0.1 

                            Image {
                                id: elettrodiPowerFirstImg
                                width: elettrodiPage.width / 12
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter 
                                anchors.bottom: elettrodiPowerFirstText.top
                                source: "../icone/elettrodi_green.png"
                            }

                            Text {
                                id: elettrodiPowerFirstText
                                text: qsTr("Power First")
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: elettrodiPowerFirstValText.top
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 20
                                font.bold: true

                            }

                            Text {
                                id: elettrodiPowerFirstValText
                                text: elettrodiPowerFirst.power 
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 60
                                font.bold: true
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter

                            }

                            ColorAnimation on border.color {
                                id: borderAnimEnterPowerFirst
                                from: ApplicationSettings.screenBlueColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 100
                                running: false
                            }

                            ColorAnimation on border.color {
                                id: borderAnimExitPowerFirst
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueColor
                                duration: 100
                                running: false
                            }


                            ColorAnimation on color {
                                id: colorAnimEnterPowerFirst
                                from: ApplicationSettings.screenBlueColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: colorAnimExitPowerFirst
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenBlueColor
                                duration: 200
                                running: false
                            }
                        }
                        
                        onFocusChanged: {
                            if(focus) {
                                borderAnimEnterPowerFirst.start()
                                elettrodiPage.currentFocusedItem = elettrodiPowerFirst
                            } else {
                                borderAnimExitPowerFirst.start()
                            }
                        }

                        function handleWheelUp() {
                            if (entered) {
                                if (elettrodiPowerFirst.power > 0)
                                    elettrodiPowerFirst.power -= 5;
                            } else {
                                back.forceActiveFocus();
                            }
                        }
                        function handleMiddleClick() {
                            entered = entered ? false : true
                            entered ? colorAnimEnterPowerFirst.start() : colorAnimExitPowerFirst.start()
                        }
                        function handleWheelDown() {
                            if (entered) {
                                if (elettrodiPowerFirst.power < 60) {
                                    elettrodiPowerFirst.power += 5;
                                }

                            } else {
                                elettrodiPowerSecond.forceActiveFocus();
                            }
                        }
                    }

                    Item {
                        id: elettrodiPowerSecond
                        width: elettrodiPage.width / 4
                        height: elettrodiPage.height * 0.35


                        property bool entered: false
                        property int power: 0

                        Rectangle {
                            id: elettrodiPowerSecondBackRect
                            anchors.fill: parent
                            anchors.topMargin: parent.width * 0.05
                            anchors.leftMargin: parent.width * 0.1
                            anchors.rightMargin: parent.width * 0.1
                            color: ApplicationSettings.screenBlueColor
                            border.color: ApplicationSettings.screenBlueColor
                            border.width: 2
                            radius: width * 0.1 

                            Image {
                                id: elettrodiPowerSecondImg
                                width: elettrodiPage.width / 12
                                height: width
                                anchors.horizontalCenter: parent.horizontalCenter 
                                anchors.bottom: elettrodiPowerSecondText.top
                                source: "../icone/elettrodi_red.png"
                            }

                            Text {
                                id: elettrodiPowerSecondText
                                text: qsTr("Power Second")
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: elettrodiPowerSecondValText.top
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 20
                                font.bold: true

                            }

                            Text {
                                id: elettrodiPowerSecondValText
                                text: elettrodiPowerSecond.power 
                                color: ApplicationSettings.screenWhiteColor
                                font.pixelSize: 60
                                font.bold: true
                                anchors.bottom: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter

                            }

                            ColorAnimation on border.color {
                                id: borderAnimEnterPowerSecond
                                from: ApplicationSettings.screenBlueColor
                                to: ApplicationSettings.screenWhiteColor
                                duration: 100
                                running: false
                            }

                            ColorAnimation on border.color {
                                id: borderAnimExitPowerSecond
                                from: ApplicationSettings.screenWhiteColor
                                to: ApplicationSettings.screenBlueColor
                                duration: 100
                                running: false
                            }


                            ColorAnimation on color {
                                id: colorAnimEnterPowerSecond
                                from: ApplicationSettings.screenBlueColor
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: colorAnimExitPowerSecond
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: ApplicationSettings.screenBlueColor
                                duration: 200
                                running: false
                            }
                        }

                        onFocusChanged: {
                            if(focus) {
                                borderAnimEnterPowerSecond.start()
                                elettrodiPage.currentFocusedItem = elettrodiPowerSecond
                            } else {
                                borderAnimExitPowerSecond.start()
                            }
                        }

                        function handleWheelUp() {
                            if (entered) {
                                if (elettrodiPowerSecond.power > 0)
                                    elettrodiPowerSecond.power -= 5;
                            } else {
                                elettrodiPowerFirst.forceActiveFocus();
                            }
                        }
                        function handleMiddleClick() {
                            entered = entered ? false : true
                            entered ? colorAnimEnterPowerSecond.start() : colorAnimExitPowerSecond.start()
                        }
                        function handleWheelDown() {
                            if (entered) {
                                if (elettrodiPowerSecond.power < 60) {
                                    elettrodiPowerSecond.power += 5;
                                }

                            } else {
                                start.forceActiveFocus();
                            }
                        }
                    }
                }
            }

            Row {
                Item {
                    id: start 
                    width: elettrodiPage.width
                    height: elettrodiPage.height * 0.15

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
                            elettrodiPage.currentFocusedItem = start
                        } else {
                            startColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        elettrodiPowerSecond.forceActiveFocus();
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
                            ApplicationSettings.totalTimeInSec += elettrodiPage.timeCounterInSec;
                            ApplicationSettings.save();
                            elettrodiPage.timeCounterInSec = 0;
                        }
                    }
                    function handleWheelDown() {
                        elettrodiSwapTime.forceActiveFocus();
                    }
                }
            }
        }

        Component.onCompleted: {
            ApplicationSettings.load();
        }
    }
}
