import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import "./component"

ApplicationWindow {
    id:mainApp
    visible: true
    width: 640
    height: 480
    title: qsTr("QtDay 2019 - workshop")

    header:TopicSelection{
        id:topic
        width:mainApp.width
        height:visible ? 54 : 0
        visible : leftMenu.selected
    }

    FontLoader {
        source: "qrc:/component/fontawesome-webfont.ttf"
    }

    LeftMenu{
        id:leftMenu
        y:topic.height
        width:mainApp.contentItem.width * .3
        height:mainApp.contentItem.height
        selectedTopic : topic.qmlName
    }

    Loader{
        id:loader
        x:leftMenu.position * leftMenu.width
        width:parent.width - x
        height:parent.height
        source: leftMenu.currentPage

        Label{
            text:qsTr("loading document...please wait")
            color : "red"
            opacity : 1 - loader.progress
            anchors.centerIn: parent
            visible:loader.status === Loader.Loading
        }

        Connections{
            ignoreUnknownSignals: true
            target : loader.item
            onCloseUploadPanel : leftMenu.showUploadPanel = false
        }
    }

    footer:RowLayout{
        width:mainApp.width
        height : 40
        FAButton{
            label: leftMenu.visible ? qsTr("Close menu") : qsTr("Open menu")
            //height:parent.height;
            Layout.fillWidth: true
            icon:"\uf0a8"
            iconRotation: leftMenu.position * 180
            onClicked: leftMenu.visible ? leftMenu.close() : leftMenu.open()
        }
        Label{
            Layout.alignment: Qt.AlignRight
            verticalAlignment: Text.AlignVCenter
            text:visible ? qsTr("Currently viewing %1 playground").arg(leftMenu.selected.uidAlias) : ""
            visible : leftMenu.selected
        }
    }


}
