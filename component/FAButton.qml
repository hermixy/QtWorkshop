import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Item{
    id:root
    property alias icon :icon.text
    property alias label : label.text
    property color color : Material.foreground
    property color bkColor : "transparent"
    property alias iconRotation : icon.rotation
    signal clicked();
    property bool selected : false

    //Layout.preferredHeight : 30
    //Layout.preferredWidth : 100
    implicitHeight:30
    implicitWidth:100

    Rectangle{
        anchors.fill: parent
        color : root.bkColor
        border.color : Material.accent
        border.width: 1
        radius:2
        visible : root.selected && !label.isEmpty
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 2

        Text{
            id : icon
            color : (root.selected && label.isEmpty) ? Material.accent : root.color
            property bool isEmpty : text === ""
            font.family: "FontAwesome"
            Layout.fillHeight: isEmpty ? false : true
            width:height
            visible : !isEmpty
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment : Text.AlignVCenter
        }
        Label{
            id:label
            color : root.color
            elide: Text.ElideRight
            property bool isEmpty : text === ""
            horizontalAlignment: icon.isEmpty ? Text.AlignHCenter :  Text.AlignLeft
            verticalAlignment : Text.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true

        }
    }

    MouseArea{
        enabled : root.visible
        hoverEnabled:true
        anchors.fill : parent
        onClicked: root.clicked();
    }

}


