import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Universal 2.15


Page {
    id: pageAboutQt
    title: qsTr("about PineScaleQML")

    focus: true

    ColumnLayout {
        id: aboutColumn
        x: parent.x
        width: parent.width
        spacing: 20

        Image {
            source: "Image/PineScaleQML.svg"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            fillMode: Image.PreserveAspectFit

            Layout.topMargin: 50
        }

        Label {
            text: "PineScaleQML" + qsTr("\t") + mainWindowModel.getVersion()
            width: parent.availableWidth
            font.pointSize: 14

            textFormat: Label.RichText
            wrapMode: Label.WordWrap

            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Label {
            text: "<html><head/><body> \
                   <p>PineScaleQML developed by Presire<br> \
                   <style>a:link {color:#6F8FFF;}</style> \
                   <a href=\"https://github.com/presire\">Visit Presire Github</a></p> \
                   </body></html>"
            width: parent.availableWidth
            font.pointSize: 14

            textFormat: Label.RichText
            wrapMode: Label.WordWrap

            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true

            Connections {
                function onLinkActivated() {
                    Qt.openUrlExternally(link)
                }
            }
        }
    }
}
