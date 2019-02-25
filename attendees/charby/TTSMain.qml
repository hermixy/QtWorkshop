import QtQuick 2.12
import QtQuick.Controls 2.5
import fr.ateam.tts 1.0
import QtQuick.Layouts 1.12
import "../../component"

Pane {
    ColumnLayout{
        anchors.fill: parent
        TextField{
            id:textSource
            placeholderText:qsTr("input here the text to play")
            Layout.fillWidth: true
        }
        FAButton{
            label:qsTr("Text to speech")
            icon:"\uf0a1"
            onClicked: tts.say( textSource.text)
            Layout.fillWidth: true
        }
    }

    TTS{
        id:tts
    }
}
