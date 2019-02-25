import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import SortFilterProxyModel 0.2
import "./component"

Drawer {
    id:root
    property var selected : null//originalList.get(0)
    property string selectedTopic : ""
    property bool showUploadPanel : false
    property url currentPage : showUploadPanel ? "qrc:/UploadPanel.qml" : selected ? selected.docRoot+selected.uidAlias+"/"+ selectedTopic: "qrc:/Welcome.qml"

    AttendeesList{
        id:originalList
    }

    SortFilterProxyModel{
        id: filteredList
        sourceModel: originalList
        sorters: StringSorter { roleName: "uidAlias";  }
        filters: RegExpFilter {
                roleName: "uidAlias"
                pattern: "^" + searchAlias.text
                caseSensitivity: Qt.CaseInsensitive
            }
    }

    ColumnLayout {
        anchors.fill:parent
        Frame {
            Layout.fillWidth: true
            RowLayout{
                FAButton {
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    icon: "\uf002"
                }

                TextField {
                    id: searchAlias
                    Layout.fillWidth: true
                    topPadding: 0
                    bottomPadding: 0
                    focus: true
                    selectByMouse: true
                    background: null
                    placeholderText: qsTr("Search")
                }
            }
        }


        ScrollView{
            Layout.fillWidth: true
            Layout.fillHeight: true
            ListView{
                id:listView
                anchors.fill: parent
                model:filteredList
                clip:true
                delegate: ItemDelegate{
                    width:listView.width
                    highlighted: root.selected ? (uidAlias === root.selected.uidAlias) && (docRoot === root.selected.docRoot) : false
                    //height:25
                    RowLayout{
                        Image{
                            source:docRoot + uidAlias + "/profile.png"
                            Layout.preferredHeight: 30
                            Layout.preferredWidth : Layout.preferredHeight
                            fillMode: Image.PreserveAspectFit

                            FAButton{
                                Layout.preferredHeight: 20
                                Layout.preferredWidth: 20
                                x:10
                                y:10
                                icon: "\uf0ed"
                                visible : docRoot !== "qrc:/attendees/"
                                enabled: false
                            }
                        }
                        Label{
                            text:uidAlias

                            elide : Text.ElideRight

                        }
                    }

                    onClicked:{
                        root.selected = model
                        root.close();
                    }
                }
            }
        }

        FAButton {

            Layout.preferredHeight: 30
            Layout.fillWidth: true
            color:"yellow"
            icon: "\uf0ee"
            label:qsTr("Upload your playground")
            onClicked:{
                root.showUploadPanel = true//uploader.triggerUpload( "/Users/charby/Downloads/CuisineAppt.pdf", "charby/CuisineAppt2.pdf")
                root.close();
            }
        }
    }
}
