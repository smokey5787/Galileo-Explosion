import QtQuick 2.5


Image {
    id: root
    source: "images/explosion-purple.png"

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 12

            anchors.centerIn: parent

            source: "images/galileocraft-med2.png"

            sourceSize.width: 700
            sourceSize.height: 394

            ParallelAnimation {
                running: true

                ScaleAnimator {
                    target: logo
                    from: 0
                    to: 1
                    duration: 700
                }

                SequentialAnimation {
                    loops: Animation.Infinite

                    ScaleAnimator {
                        target: logo
                        from: 1
                        to: 0
                        duration: 1000
                    }
                    ScaleAnimator {
                        target: logo
                        from: 0.2
                        to: 1
                        duration: 1000
                    }
                }
            }
        
        }


        Rectangle {
            radius: 4
            color: "#ccadec"
            opacity: 0.9
            y: parent.height - (parent.height - logo.y) / 3 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            height: 6
            width: height*32
            Rectangle {
                radius: 3
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: (parent.width / 6) * (stage - 1)
                color: "#7F3FBF"
                Behavior on width { 
                    PropertyAnimation {
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
