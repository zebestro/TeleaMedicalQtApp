import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App 1.0


FocusScope {
    Item {
        id: infoPage
        width: appWind.width
        height: appWind.height

        property bool isAuthorized: false
        property Item currentFocusedItem

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            hoverEnabled: true

            onWheel: (wheel) => {
                if (wheel.angleDelta.y > 0) {
                    infoPage.currentFocusedItem.handleWheelUp()
                } else if (wheel.angleDelta.y < 0) {
                    infoPage.currentFocusedItem.handleWheelDown()
                }
            }

            onClicked: (mouse) => {
                if (mouse.button === Qt.MiddleButton) {
                    infoPage.currentFocusedItem.handleMiddleClick()
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
                    width: infoPage.width / 6
                    height: infoPage.height * 0.15

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
                                to: "white"
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: backColorAnimExit
                                from: "white"
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }
                        }
                    }

                    onFocusChanged: {
                        if(focus) {
                            backColorAnimEnter.start()
                            infoPage.currentFocusedItem = back
                        } else {
                            backColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        info.forceActiveFocus();
                    }
                    function handleMiddleClick() {
                        infoPage.isAuthorized = false;
                        pwdInputField.text = "";
                        newPwdInputField.text = "";
                        repeatNewPwdInputField.text = "";
                        appStackView.pop();
                    }
                    function handleWheelDown() {
                        pwdInput.forceActiveFocus();
                    }
                }

                Column {
                    Item {
                        width: infoPage.width * 2 / 3
                        height: infoPage.height * 0.1

                        Text {
                            id: header
                            anchors.centerIn: parent
                            text: qsTr("TOTAL TIME (min)")
                            color: "white"
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.4
                        }
                    }

                    Item {
                        width: infoPage.width * 2 / 3
                        height: infoPage.height * 0.1

                        Text {
                            id: headerVal
                            anchors.centerIn: parent
                            text: Math.floor(ApplicationSettings.totalTimeInSec / 60)
                            color: "white"
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.4
                        }
                    }
                }

                Item {
                    width: infoPage.width / 6
                    height: infoPage.height * 0.2
                }
            }



            Row {
                Item {
                    id: infoPwdCtrl
                    width: infoPage.width * 0.5
                    height: infoPage.height * 0.65

                    Row {
                        Item {
                            id: infoPwdCtrlLeft
                            width: infoPwdCtrl.width * 0.5
                            height: infoPwdCtrl.height

                            Column {
                                Item {
                                    id: isAuthorized
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8

                                    Text {
                                        id: isAuthorizedText
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.bottom: parent.bottom
                                        text: qsTr("Status")
                                        color: "white"
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4
                                    }
                                }

                                Item {
                                    id: isAuthorizedStatus
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8

                                    Text {
                                        id: isAuthorizedStatusText
                                        anchors.centerIn: parent
                                        text: infoPage.isAuthorized ? qsTr("Authorized") : qsTr("Not Authorized")
                                        color: infoPage.isAuthorized ? "#28fc03" : "yellow"
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4
                                    }
                                }

                                /*
                                Item {
                                    id: newPwd
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                    visible: infoPage.isAuthorized
                                }

                                Item {
                                    id: newPwdInput
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                    visible: infoPage.isAuthorized
                                }

                                Item {
                                    id: repeatNewPwd
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                    visible: infoPage.isAuthorized

                                }

                                Item {
                                    id: repeatNewPwdInput
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                }

                                Item {
                                    id: resetTotalTime
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 4
                                }
                                */
                            }
                        }

                        Item {
                            id: infoPwdCtrlRight
                            width: infoPwdCtrl.width * 0.5
                            height: infoPwdCtrl.height

                            Column {
                                Item {
                                    id: pwd
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8

                                    Text {
                                        id: pwdText
                                        anchors.bottom: parent.bottom
                                        text: qsTr("Password")
                                        color: "white"
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4
                                    }
                                }

                                Item {
                                    id: pwdInput
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8


                                    TextField {
                                        id: pwdInputField
                                        width: parent.width * 0.8
                                        height: parent.height * 0.8
                                        color: ApplicationSettings.screenBlueColor
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4
                                        echoMode: TextField.Password

                                        background: Rectangle {
                                            anchors.fill: parent
                                            color: ApplicationSettings.screenBlueHalfTransparentColor
                                            radius: width / 2

                                            ColorAnimation on color {
                                                id: pwdInputAnimEnter
                                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                                to: "white"
                                                duration: 200
                                                running: false
                                            }

                                            ColorAnimation on color {
                                                id: pwdInputAnimExit
                                                from: "white"
                                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                                duration: 200
                                                running: false
                                            }
                                        }
                                    }

                                    onFocusChanged: {
                                        if(focus) {
                                            pwdInputAnimEnter.start()
                                            infoPage.currentFocusedItem = pwdInput
                                        } else {
                                            pwdInputAnimExit.start()
                                        }
                                    }

                                    function handleWheelUp() {
                                        back.forceActiveFocus();
                                    }
                                    function handleMiddleClick() {
                                        keyboard.targetInput = pwdInputField;
                                        layout.children[0].forceActiveFocus();
                                        pwdInputField.color = "white"
                                    }
                                    function handleWheelDown() {
                                        if (newPwdInput.visible) {
                                            newPwdInput.forceActiveFocus();
                                        } else {
                                            info.forceActiveFocus();
                                        }
                                    }
                                }

                                Item {
                                    id: newPwd
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                    visible: infoPage.isAuthorized

                                    Text {
                                        id: newPwdText
                                        anchors.bottom: parent.bottom
                                        text: qsTr("New password")
                                        color: "white"
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4
                                    }
                                }

                                Item {
                                    id: newPwdInput
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                    visible: infoPage.isAuthorized

                                    TextField {
                                        id: newPwdInputField
                                        width: parent.width * 0.8
                                        height: parent.height * 0.8
                                        color: ApplicationSettings.screenBlueColor
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4

                                        background: Rectangle {
                                            anchors.fill: parent
                                            color: ApplicationSettings.screenBlueHalfTransparentColor
                                            radius: width / 2

                                            ColorAnimation on color {
                                                id: newPwdInputAnimEnter
                                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                                to: "white"
                                                duration: 200
                                                running: false
                                            }

                                            ColorAnimation on color {
                                                id: newPwdInputAnimExit
                                                from: "white"
                                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                                duration: 200
                                                running: false
                                            }
                                        }
                                    }

                                    onFocusChanged: {
                                        if(focus) {
                                            newPwdInputAnimEnter.start()
                                            infoPage.currentFocusedItem = newPwdInput
                                        } else {
                                            newPwdInputAnimExit.start()
                                        }
                                    }

                                    function handleWheelUp() {
                                        pwdInput.forceActiveFocus();
                                    }
                                    function handleMiddleClick() {
                                        keyboard.targetInput = newPwdInputField;
                                        layout.children[0].forceActiveFocus();
                                        newPwdInputField.color = "white"
                                    }
                                    function handleWheelDown() {
                                        repeatNewPwdInput.forceActiveFocus();
                                    }
                                }

                                Item {
                                    id: repeatNewPwd
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                    visible: infoPage.isAuthorized

                                    Text {
                                        id: repeatNewPwdText
                                        anchors.bottom: parent.bottom
                                        text: qsTr("Repeat new password")
                                        color: "white"
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4
                                    }
                                }

                                Item {
                                    id: repeatNewPwdInput
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 8
                                    visible: infoPage.isAuthorized

                                    TextField {
                                        id: repeatNewPwdInputField
                                        width: parent.width * 0.8
                                        height: parent.height * 0.8
                                        color: ApplicationSettings.screenBlueColor
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4

                                        background: Rectangle {
                                            anchors.fill: parent
                                            color: ApplicationSettings.screenBlueHalfTransparentColor
                                            radius: width / 2

                                            ColorAnimation on color {
                                                id: repeatNewPwdInputAnimEnter
                                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                                to: "white"
                                                duration: 200
                                                running: false
                                            }

                                            ColorAnimation on color {
                                                id: repeatNewPwdInputAnimExit
                                                from: "white"
                                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                                duration: 200
                                                running: false
                                            }
                                        }
                                    }

                                    onFocusChanged: {
                                        if(focus) {
                                            repeatNewPwdInputAnimEnter.start()
                                            infoPage.currentFocusedItem = repeatNewPwdInput
                                        } else {
                                            repeatNewPwdInputAnimExit.start()
                                        }
                                    }

                                    function handleWheelUp() {
                                        newPwdInput.forceActiveFocus();
                                    }
                                    function handleMiddleClick() {
                                        keyboard.targetInput = repeatNewPwdInputField;
                                        layout.children[0].forceActiveFocus();
                                        repeatNewPwdInputField.color = "white"
                                    }
                                    function handleWheelDown() {
                                        resetTotalTime.forceActiveFocus();
                                    }
                                }

                                Item {
                                    id: resetTotalTime
                                    width: infoPwdCtrlRight.width
                                    height: infoPwdCtrlRight.height / 4
                                    visible: infoPage.isAuthorized

                                    Button {
                                        id: resetTotalTimeButton
                                        width: parent.width * 0.8
                                        height: parent.height * 0.4

                                        Text {
                                            anchors.centerIn: parent
                                            id: resetTotalTimeButtonText
                                            text: qsTr("Reset total time")
                                            color: ApplicationSettings.screenBlueColor
                                            font.family: headerFont.name
                                            font.pixelSize: parent.height * 0.5
                                        }

                                        anchors.verticalCenter: parent.verticalCenter
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4

                                        background: Rectangle {
                                            anchors.fill: parent
                                            color: ApplicationSettings.screenBlueHalfTransparentColor
                                            radius: width / 2

                                            ColorAnimation on color {
                                                id: resetTotalTimeColorAnimEnter
                                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                                to: "white"
                                                duration: 200
                                                running: false
                                            }

                                            ColorAnimation on color {
                                                id: resetTotalTimeColorAnimExit
                                                from: "white"
                                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                                duration: 200
                                                running: false
                                            }
                                        }
                                    }

                                    onFocusChanged: {
                                        if(focus) {
                                            resetTotalTimeColorAnimEnter.start()
                                            infoPage.currentFocusedItem = resetTotalTime
                                        } else {
                                            resetTotalTimeColorAnimExit.start()
                                        }
                                    }

                                    function handleWheelUp() {
                                        repeatNewPwdInput.forceActiveFocus();
                                    }
                                    function handleMiddleClick() {
                                        ApplicationSettings.totalTimeInSec = 0;
                                        ApplicationSettings.save();
                                    }
                                    function handleWheelDown() {
                                        info.forceActiveFocus();
                                    }
                                }
                            }
                        }
                    }
                }

                Item {
                    id: infoKeyboard
                    width: infoPage.width * 0.5
                    height: infoPage.height * 0.65

                    Item {
                        id: keyboard
                        property TextField targetInput

                        width: parent.width * 0.5
                        height: parent.height * 0.5
                        anchors.centerIn: parent

                        signal keyPressed(string text)

                        GridLayout {
                            id: layout
                            anchors.fill: parent
                            anchors.margins: 4
                            rows: 4
                            columns: 5

                            Repeater {
                                model: [
                                    "1", "2", "3", "A", "D",
                                    "4", "5", "6", "B", "E",
                                    "7", "8", "9", "C", "F",
                                    "0", "<", "Enter", "Clear", "ESC"
                                ]
                                delegate: Button {
                                    id: btn
                                    Text {
                                        anchors.centerIn: parent
                                        id: infoButtonText
                                        text: modelData
                                        color: ApplicationSettings.screenBlueColor
                                        font.family: headerFont.name
                                        font.pixelSize: parent.height * 0.4
                                    }

                                    Layout.preferredWidth: keyboard.width / 5
                                    Layout.preferredHeight: keyboard.height / 5

                                    font.pixelSize: 10
                                    background: Rectangle {
                                        color: ApplicationSettings.screenBlueHalfTransparentColor
                                        radius: 5

                                        ColorAnimation on color {
                                            id: btnAnimEnter
                                            from: ApplicationSettings.screenBlueHalfTransparentColor
                                            to: "white"
                                            duration: 200
                                            running: false
                                        }

                                        ColorAnimation on color {
                                            id: btnAnimExit
                                            from: "white"
                                            to: ApplicationSettings.screenBlueHalfTransparentColor
                                            duration: 200
                                            running: false
                                        }
                                    }

                                    function applyPwd(st) {
                                        if (st === ApplicationSettings.password) {
                                            infoPage.isAuthorized = true;
                                            console.log("Success! You're authenticated now.");
                                            keyboard.targetInput.parent.forceActiveFocus();
                                            keyboard.targetInput.color = ApplicationSettings.screenBlueColor;
                                            pwdInputField.text = "";
                                        } else {
                                            infoPage.isAuthorized = false;
                                            console.log("Bad Authentication. Wrong Password...");
                                        }
                                    }

                                    function applyNewPwd(st) {
                                        keyboard.targetInput.parent.forceActiveFocus();
                                        keyboard.targetInput.color = ApplicationSettings.screenBlueColor;
                                    }

                                    function applyRepeatNewPwd(st) {
                                        keyboard.targetInput.parent.forceActiveFocus();
                                        keyboard.targetInput.color = ApplicationSettings.screenBlueColor;
                                        if (newPwdInputField.text === repeatNewPwdInputField.text && newPwdInputField.text.length >= 5) {
                                            ApplicationSettings.password = newPwdInputField.text;
                                            console.log("New password has been set successfully");
                                            newPwdInputField.text = "";
                                            repeatNewPwdInputField.text = "";
                                            infoPage.isAuthorized = false;
                                            ApplicationSettings.save();
                                            pwdInput.forceActiveFocus();
                                        }
                                    }

                                    onFocusChanged: {
                                        if(focus) {
                                            btnAnimEnter.start()
                                            infoPage.currentFocusedItem = btn
                                        } else {
                                            btnAnimExit.start()
                                        }
                                    }

                                    function handleWheelUp() {
                                        let indexForPrev = (layout.children.indexOf(btn) - 1 + (layout.children.length - 1)) % (layout.children.length - 1)
                                        layout.children[indexForPrev].forceActiveFocus();
                                    }
                                    function handleMiddleClick() {
                                        if (infoButtonText.text === "Enter") {
                                            if (keyboard.targetInput === pwdInputField) {
                                                applyPwd(keyboard.targetInput.text);
                                            } else if (keyboard.targetInput === newPwdInputField) {
                                                applyNewPwd(keyboard.targetInput.text);
                                            } else if (keyboard.targetInput === repeatNewPwdInputField) {
                                                applyRepeatNewPwd(keyboard.targetInput.text);
                                            }
                                        } else if (infoButtonText.text === "<") {
                                            keyboard.targetInput.text = keyboard.targetInput.text.slice(0, -1);
                                        } else if (infoButtonText.text === "Clear") {
                                            keyboard.targetInput.text =  "";
                                        } else if (infoButtonText.text === "ESC") {
                                            keyboard.targetInput.parent.forceActiveFocus();
                                            keyboard.targetInput.color = ApplicationSettings.screenBlueColor;
                                        } else {
                                            keyboard.targetInput.text += infoButtonText.text;
                                        }
                                    }
                                    function handleWheelDown() {
                                        let indexForNext = (layout.children.indexOf(btn) + 1) % (layout.children.length - 1)
                                        layout.children[indexForNext].forceActiveFocus();
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Row {
                Item {
                    id: info 
                    width: infoPage.width
                    height: infoPage.height * 0.2

                    Button {
                        id: infoButton
                        width: parent.width * 0.1
                        height: parent.height * 0.25

                        Text {
                            anchors.centerIn: parent
                            id: infoButtonText
                            text: qsTr("INFO")
                            color: ApplicationSettings.screenBlueColor
                            font.family: headerFont.name
                            font.pixelSize: parent.height * 0.5
                        }

                        anchors.centerIn: parent
                        font.family: headerFont.name
                        font.pixelSize: parent.height * 0.4

                        background: Rectangle {
                            anchors.fill: parent
                            color: ApplicationSettings.screenBlueHalfTransparentColor
                            radius: width / 2

                            ColorAnimation on color {
                                id: infoColorAnimEnter
                                from: ApplicationSettings.screenBlueHalfTransparentColor
                                to: "white"
                                duration: 200
                                running: false
                            }

                            ColorAnimation on color {
                                id: infoColorAnimExit
                                from: "white"
                                to: ApplicationSettings.screenBlueHalfTransparentColor
                                duration: 200
                                running: false
                            }
                        }
                    }

                    onFocusChanged: {
                        if(focus) {
                            infoColorAnimEnter.start()
                            infoPage.currentFocusedItem = info
                        } else {
                            infoColorAnimExit.start()
                        }
                    }

                    function handleWheelUp() {
                        if (resetTotalTime.visible) {
                            resetTotalTime.forceActiveFocus();
                        } else {
                            pwdInput.forceActiveFocus();
                        }
                    }
                    function handleMiddleClick() {
                        infoPage.isAuthorized = false;
                        pwdInputField.text = "";
                        newPwdInputField.text = "";
                        repeatNewPwdInputField.text = "";
                        appStackView.push(addInfoPageTest);
                    }
                    function handleWheelDown() {
                        back.forceActiveFocus();
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
