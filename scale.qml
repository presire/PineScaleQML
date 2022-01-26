import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Universal 2.15
import MainWindow 1.0

Page {
    id: pageScale
    title: qsTr("Scale")

    CMainWindow {
        id: mainWindowModel;
    }

    // MainWindow's Control
    // Scale UI Control
    ScrollView {
        id: scrollScale
        width: parent.width
        height : parent.height
        contentWidth: manipulateItem.width    // The important part
        contentHeight: manipulateItem.height  // Same
        anchors.fill: parent
        clip : true                       // Prevent drawing column outside the scrollview borders

        ColumnLayout {
            id: manipulateItem
            x: parent.x
            y: parent.y
            width: pageScale.width
            Layout.fillWidth: true
            spacing: 0
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Label {
                id: labelScale
                text: "Current Scale: " + mainWindowModel.getCurrentScale(pageScale.width)
                font.pointSize: 11

                horizontalAlignment: Label.AlignLeft
                verticalAlignment: Label.AlignVCenter
                Layout.topMargin: 10
                Layout.leftMargin: 10
                Layout.fillWidth: true
                Layout.fillHeight: true

                wrapMode: Label.WordWrap
            }

            Button {
                id: scale_2_0_Btn
                x: (parent.width / 2) - width / 2
                width: parent.width / 2
                height: 35
                text: qsTr("Scale 2.0")

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 20

                Connections {
                    target: scale_2_0_Btn
                    function onClicked() {
                        mainWindowModel.onClickedScale_2_0()
                    }
                }
            }

            Button {
                id: scale_1_75_Btn
                x: (parent.width / 2) - width / 2
                width: parent.width / 2
                height: 35
                text: qsTr("Scale 1.75")

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 20

                Connections {
                    target: scale_1_75_Btn
                    function onClicked() {
                        mainWindowModel.onClickedScale_1_75();
                    }
                }
            }

            Button {
                id: scale_1_5_Btn
                x: (parent.width / 2) - width / 2
                width: parent.width / 2
                height: 35
                text: qsTr("Scale 1.5")

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 20

                Connections {
                    target: scale_1_5_Btn
                    function onClicked() {
                        mainWindowModel.onClickedScale_1_5();
                    }
                }
            }

            Button {
                id: scale_1_25_Btn
                x: (parent.width / 2) - width / 2
                width: parent.width / 2
                height: 35
                text: qsTr("Scale 1.25")

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 20

                Connections {
                    target: scale_1_25_Btn
                    function onClicked() {
                        mainWindowModel.onClickedScale_1_25();
                    }
                }
            }

            Button {
                id: scale_1_0_Btn
                x: (parent.width / 2) - width / 2
                width: parent.width / 2
                height: 35
                text: qsTr("Scale 1.0")

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.topMargin: 20

                Connections {
                    target: scale_1_0_Btn
                    function onClicked() {
                        mainWindowModel.onClickedScale_1_0();
                    }
                }
            }

            RowLayout {
                id: saveBtnLayout
                x: pageScale.x
                width: pageScale.width
                spacing: 20

                Layout.topMargin: 20
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                TextField {
                    id: strInput
                    text: mainWindowModel.getPassword()
                    placeholderText: qsTr("Input Password...")
                    width: pageScale.width - savePasswordBtn.width - parent.spacing * 2 - 100
                    implicitWidth: pageScale.width - savePasswordBtn.width - parent.spacing * 2 - 100
                    font.pixelSize: 15
                    selectedTextColor: "#393939"

                    echoMode: TextField.Password
                    passwordMaskDelay: 2000

                    focus: true
                    cursorVisible: true
                    horizontalAlignment: TextField.AlignRight

                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.leftMargin: 50
                }

                Button {
                    id: savePasswordBtn
                    text: qsTr("Save Password")

                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.rightMargin: 50

                    Connections {
                        target: savePasswordBtn
                        function onClicked() {
                            mainWindowModel.savePassword(strInput.text);
                        }
                    }
                }
            }

            RowLayout {
                id: quitBtnLayout
                x: parent.x
                width: pageScale.width
                spacing: 20

                Layout.topMargin: 20
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Button {
                    id: restartPhoshBtn
                    width: 150
                    height: 35
                    text: qsTr("Restart Phosh")

                    Connections {
                        target: restartPhoshBtn
                        function onClicked() {
                            mainWindowModel.onClickedPhosh(strInput.text);
                            Qt.quit();
                        }
                    }
                }

                Button {
                    id: quitAppBtn
                    width: 150
                    height: 35
                    text: qsTr("Quit PineScaleQML")

                    Connections {
                        target: quitAppBtn
                        function onClicked() {
                            quitDialog.open();
                        }
                    }
                }
            }
        }
    }

    Dialog {
        id: quitDialog
        title: "Quit PineScaleQML"
        x: 0
        y: Math.round(pageScale.height / 6)
        width: pageScale.width
        contentHeight: quitColumn.height

        modal: true
        focus: true
        closePolicy: Dialog.CloseOnEscape

        ColumnLayout {
            id: quitColumn
            x: parent.x
            width: parent.width
            spacing: 20

            Label {
                text: "Do you want to quit PineScaleQML?"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.bottomMargin: 20
            }

            RowLayout {
                x: quitDialog.x
                width: quitDialog.width
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 20
                spacing: 20

                Button {
                    id: quitDialogButtonOK
                    text: "OK"
                    Layout.alignment: Qt.AlignHCenter

                    Connections {
                        target: quitDialogButtonOK
                        function onClicked() {
                            quitDialog.close()
                            Qt.quit()
                        }
                    }
                }

                Button {
                    id: quitDialogButtonCancel
                    text: "Cancel"
                    focus: true
                    Layout.alignment: Qt.AlignHCenter

                    Connections {
                        target: quitDialogButtonCancel
                        function onClicked() {
                            quitDialog.close()
                        }
                    }
                }
            }
        }
    }
}
