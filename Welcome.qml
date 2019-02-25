import QtQuick 2.12
import QtQuick.Controls 2.5

Pane {

    SwipeView {
        id: view

        currentIndex: 0
        anchors.fill:parent
        anchors.bottomMargin: 30
        clip:true

        Label {
            wrapMode: Text.WordWrap
            text:"<h1>Welcome to the workshop</h1>
<h2> How to start ?</h2>
<ul>
<li>Fork and clone the base project
<li>Edit 'AttendeesList.qml and add an element with your alias
<li>make a copy of the 'template' directory inside 'attendees' directory and rename it with your alias
<li>(optional) customize profile.png
<li> add the content of the former copy of the 'template' directory to the qrc
<li> make a pull request
</ul>
"
        }
        Label {
            wrapMode: Text.WordWrap
            text:"<h1>Welcome to the workshop</h1>
<h2> How to start ?</h2>
<ul>
<li>Edit 'AttendeesList.qml and add an element with your alias
<li>make a copy of the 'template' directory inside 'attendees' directory and rename it with your alias
<li>(optional) customize profile.png
<li> add the content of the former copy of the 'template' directory to the qrc
</ul>
"
        }
        Label {
            id: thirdPage
        }
    }

    PageIndicator {
        count: view.count
        currentIndex: view.currentIndex
        anchors.top: view.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
