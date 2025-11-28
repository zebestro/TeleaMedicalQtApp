import QtQuick

import QtQuick.Controls.Basic

// Dial {
//     id: mainmenu
//     color: bg_color
//     anchors.fill: parent
//     visible: true
// 
//     background: Rectangle {
//         x: control.width / 2 - width / 2
//         y: control.height / 2 - height / 2
//         implicitWidth: 140
//         implicitHeight: 140
//         width: Math.max(64, Math.min(control.width, control.height))
//         height: width
//         color: "transparent"
//         radius: width / 2
//         border.color: control.pressed ? "#17a81a" : "#21be2b"
//         opacity: control.enabled ? 1 : 0.3
//     }
// 
//     handle: Rectangle {
//         id: handleItem
//         x: control.background.x + control.background.width / 2 - width / 2
//         y: control.background.y + control.background.height / 2 - height / 2
//         width: 16
//         height: 16
//         color: control.pressed ? "#17a81a" : "#21be2b"
//         radius: 8
//         antialiasing: true
//         opacity: control.enabled ? 1 : 0.3
//         transform: [
//             Translate {
//                 y: -Math.min(control.background.width, control.background.height) * 0.4 + handleItem.height / 2
//             },
//             Rotation {
//                 angle: control.angle
//                 origin.x: handleItem.width / 2
//                 origin.y: handleItem.height / 2
//             }
//         ]
//     }
// }

Rectangle
{
    id: mainmenu
    color: bg_color
    anchors.fill: parent
    visible: true

    // variable used for encoder navigation
    // (it keeps track of the position of the cursor on screen)
    property int index: 1

    // MouseArea as big as the screen, it will handle the encoder navigation,
    // mapped as a mouse wheel
    MouseArea
    {
        id: encoder
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton

        onWheel: function(wheel)
        {
            // Increase/decrease cursor position on wheel scroll
            if (wheel.angleDelta.y >= 0) index -= 1
            else index +=1

            // Rollover
            if (index > 2) index = 0
            else if (index < 0) index = 2
        }

        onClicked: function(mouse)
        {
            switch (parent.state)
            {
                case "selezione_elettrodi":
                    screen_elettrodi.open()
                    break

                case "selezione_manipolo":
                    screen_manipolo.open()
                    break

                case "selezione_guanti":
                    screen_guanti.open()
                    break
            }
        }
    }

    // Screen states, ie: what icon is highlighted on screen?
    states:
    [
        State
        {
            name: "selezione_elettrodi"
            when: index == 0
            PropertyChanges
            {
                target: icona_elettrodi; opacity: 1
            }
        },

        State
        {
            name: "selezione_manipolo"
            when: index == 1
            PropertyChanges
            {
                target: icona_manipolo; opacity: 1
            }
        },

        State
        {
            name: "selezione_guanti"
            when: index == 2
            PropertyChanges
            {
                target: icona_guanti; opacity: 1
            }
        }
    ]

    transitions: Transition
    {
        NumberAnimation
        {
            properties: "opacity";
            duration: 150;
        }
    }


    // Icons of the device functions //////////////////////////////
    Image
    {
        id: icona_elettrodi
        width: 200
        height: 200
        source: "../img/elettrodi.png"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: (parent.height/8)
        anchors.horizontalCenterOffset: -(parent.width/4)

        opacity: 0.5    // default value, when NOT highlighted

        // scale change when pressed either by the touchscreen OR by the encoder press
        scale: ((encoder.pressed && mainmenu.state == "selezione_elettrodi") ||
                (mousearea_elettrodi.pressed)) ?
                   0.97 : 1

        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        // MouseArea for touch interaction
        MouseArea
        {
            id: mousearea_elettrodi
            anchors.fill: parent
            onPressed: mainmenu.index = 0
            onClicked: {
                if (containsMouse)
                    screen_elettrodi.open()
            }
        }
    }

    Image
    {
        id: icona_manipolo
        width: 200
        height: 200
        source: "../img/manipolo.png"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -(parent.height/8)
        anchors.horizontalCenterOffset: 0

        opacity: 0.5    // default value, when NOT highlighted

        // scale change when pressed either by the touchscreen OR by the encoder press
        scale: ((encoder.pressed && mainmenu.state == "selezione_manipolo") ||
                (mousearea_manipolo.pressed)) ?
                   0.97 : 1

        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        // MouseArea for touch interaction
        MouseArea
        {
            id: mousearea_manipolo
            anchors.fill: parent
            onPressed: mainmenu.index = 1
            onClicked: {
                if (containsMouse)
                    screen_manipolo.open()
            }
        }
    }

    Image
    {
        id: icona_guanti
        width: 200
        height: 200
        source: "../img/guanti.png"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: (parent.height/8)
        anchors.horizontalCenterOffset: (parent.width/4)

        opacity: 0.5    // default value, when NOT highlighted

        // scale change when pressed either by the touchscreen OR by the encoder press
        scale: ((encoder.pressed && mainmenu.state == "selezione_guanti") ||
                (mousearea_guanti.pressed)) ?
                   0.97 : 1

        Behavior on scale
        {
            NumberAnimation
            {
                duration: 150
            }
        }

        // MouseArea for touch interaction
        MouseArea
        {
            id: mousearea_guanti
            anchors.fill: parent
            onPressed: mainmenu.index = 2
            onClicked: {
                if (containsMouse)
                    screen_guanti.open()
            }
        }
    }

}

