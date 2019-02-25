import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import "./component"

Frame {
    id:root
    property string qmlName :lstTopics.get(view.currentIndex).qmlName

    ListModel{
        id:lstTopics
        ListElement{ label:"SoundBox"; image:"\uf1c7"; qmlName:"SoundBoxMain.qml" }
        ListElement{ label:"Camera"; image:"\uf030"; qmlName:"CameraMain.qml" }
        ListElement{ label:"Map"; image:"\uf279"; qmlName:"MapMain.qml" }
        ListElement{ label:"TTS"; image:"\uf29d"; qmlName:"TTSMain.qml" }
        //ListElement{ label:"4InARow(Qt3D)"; image:"\uf1b3"; qmlName:"TTSMain.qml" }
        ListElement{ label:"Sensors"; image:"\uf076"; qmlName:"SensorsMain.qml" }
        //ListElement{ label:"BlueAreU"; image:"\uf293"; qmlName:"BTMain.qml" }
        ListElement{ label:"Uncharted"; image:"\uf1fe"; qmlName:"ChartsMain.qml" }
        ListElement{ label:"Flick'r"; image:"\uf16e"; qmlName:"FlickrMain.qml" }
    }


    FAButton{
        width:height; height: parent.height
        icon : "\uf104"
        visible : view.currentIndex > 0
        onClicked: view.currentIndex--
    }
    ListView{
        id:view
        anchors.fill: parent
        anchors.leftMargin: height
        anchors.rightMargin: height
        spacing:5
        //currentIndex: 3
        clip : true
        orientation : ListView.Horizontal
        highlightFollowsCurrentItem:true
        snapMode: ListView.SnapToItem
        highlightRangeMode: ListView.ApplyRange
        model:lstTopics
        delegate: FAButton{
            height: view.height
            width: 3 * height - view.spacing
                selected : view.currentIndex === index
                label:model.label
                icon : model.image
                onClicked: view.currentIndex = index

            }

    }
    FAButton{
        width:height; height: parent.height
        anchors.right:parent.right
        icon : "\uf105"
        visible : view.currentIndex < (lstTopics.count-1)
        onClicked: view.currentIndex++
    }


}
