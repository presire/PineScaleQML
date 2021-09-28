import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import MainWindow 1.0

ApplicationWindow {
    id: mainWindow
    width: 360
    height: 720
    visible: true
    color: Qt.rgba(255, 255, 255, 1)

    CMainWindow {
        id: mainWindowModel;
    }

    // MenuBar
    MenuBar {
        id: menu
        x: 0
        y: 0
        width: mainWindow.width
        font.pixelSize: {
            if(mainWindow.height <= 720) 14;
            else if(mainWindow.height > 720 && mainWindow.height <= 1080) 16;
            else 18;
        }

        // [File] Menu
        Menu {
            title: qsTr("&File(&F)")
            font.pixelSize: {
                if(mainWindow.height <= 720) 14;
                else if(mainWindow.height > 720 && mainWindow.height <= 1080) 16;
                else 18;
            }

            // [Quit] SubMenu
            Action {
                text: "Quit(&O)"
                onTriggered: {
                    quitDialog.open();
                }
            }
        }

        // [Help] Menu
        Menu {
            title: qsTr("&Help(&H)")
            font.pixelSize: {
                if(mainWindow.height <= 720) 14;
                else if(mainWindow.height > 720 && mainWindow.height <= 1080) 16;
                else 18;
            }

            // [about PineScale] SubMenu
            Action {
                text: "about PineScaleQML(&A)"
                onTriggered: {
                    aboutDialog.open()
                }
            }

            // [about Qt] SubMenu
            Action {
                text: "about Qt(&t)"
                onTriggered: {
                    aboutQtDialog.open()
                }
            }
        }
    }

    // MainWindow's Control
    ColumnLayout {
        x: 0
        y: menu.height
        width: mainWindow.width
        height: mainWindow.height - menu.height

        Label {
            text: "Current Scale: " + mainWindowModel.getCurrentScale(mainWindow.width)
            Layout.alignment: Qt.AlignRight
            verticalAlignment: Label.AlignVCenter
            Layout.rightMargin: Math.round(20 * (mainWindow.width / 360))
            font.pixelSize: {
                if(720 / mainWindow.width >= 1.75) 12;
                else if(720 / mainWindow.width >= 1.5) 14;
                else if(720 / mainWindow.width >= 1.25) 16;
                else 20;
            }
        }

        Button {
            id: scale_2_0_Btn
            x: (parent.width / 2) - width / 2
            y: (parent.height / 2) + height / 2
            width: 200
            height: 35
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            text: qsTr("Scale 2.0")
            highlighted : true
            scale: mainWindow.width / 360

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
            y: (parent.height / 2) + height / 2
            width: 200
            height: 35
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            text: qsTr("Scale 1.75")
            highlighted : true
            scale: mainWindow.width / 360

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
            y: (parent.height / 2) + height / 2
            width: 200
            height: 35
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            text: qsTr("Scale 1.5")
            highlighted : true
            scale: mainWindow.width / 360

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
            y: (parent.height / 2) + height / 2
            width: 200
            height: 35
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            text: qsTr("Scale 1.25")
            highlighted : true
            scale: mainWindow.width / 360

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
            y: (parent.height / 2) + height / 2
            width: 200
            height: 35
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            text: qsTr("Scale 1.0")
            highlighted : true
            scale: mainWindow.width / 360

            Connections {
                target: scale_1_0_Btn
                function onClicked() {
                    mainWindowModel.onClickedScale_1_0();
                }
            }
        }

        RowLayout {
            x: 0
            width: mainWindow.width
            Layout.alignment: Qt.AlignHCenter
            scale: mainWindow.width / 360
            spacing: 20

            Button {
                id: savePasswordBtn
                width: 120
                height: 35
                Layout.alignment: Qt.AlignLeft
                text: qsTr("Save Password")
                highlighted : true

                Connections {
                    target: savePasswordBtn
                    function onClicked() {
                        mainWindowModel.savePassword(strInput.text);
                    }
                }
            }

            TextField {
                id: strInput
                text: mainWindowModel.getPassword()
                width: 200
                height: 35
                font.pixelSize: 15
                selectedTextColor: "#393939"

                echoMode: TextInput.Password
                passwordMaskDelay: 2000

                focus: true
                cursorVisible: true
                Layout.alignment: Qt.AlignRight
                horizontalAlignment: Text.AlignRight
            }
        }

        RowLayout {
            x: 0
            width: mainWindow.width
            Layout.alignment: Qt.AlignHCenter
            scale: mainWindow.width / 360
            spacing: 20

            Button {
                id: restartPhoshBtn
                width: 150
                height: 35
                Layout.alignment: Qt.AlignLeft
                Layout.rightMargin: 20 * (mainWindow.width / 360)
                text: qsTr("Restart Phosh")
                highlighted : true

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
                Layout.alignment: Qt.AlignRight
                text: qsTr("Quit PineScale")
                highlighted : true

                Connections {
                    target: quitAppBtn
                    function onClicked() {
                        quitDialog.open();
                    }
                }
            }
        }
    }

    Dialog {
        id: quitDialog
        title: "Quit PineScale"
        x: Math.round((mainWindow.width - width) / 2)
        y: Math.round(mainWindow.height / 6)
        width: Math.round(Math.min(mainWindow.width, mainWindow.height) / 10 * 9)
        contentHeight: quitColumn.height

        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape

        ColumnLayout {
            id: quitColumn
            x: parent.x
            width: parent.width
            spacing: 20 * (mainWindow.width / 360)

            Label {
                text: "Do you want to quit PineScale?"
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.bottomMargin: 20
                scale: mainWindow.width / 360
            }

            RowLayout {
                x: quitDialog.x
                width: quitDialog.width
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 20
                scale: mainWindow.width / 360

                Button {
                    id: quitDialogButtonOK
                    text: "OK"

                    width: 100
                    height: 20
                    Layout.alignment: Qt.AlignHCenter
                    highlighted : true

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

                    width: 100
                    height: 20
                    Layout.alignment: Qt.AlignHCenter
                    highlighted : true

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

    Dialog {
        id: aboutDialog
        title: "about PineScaleQML"
        x: Math.round((mainWindow.width - width) / 2)
        y: Math.round(mainWindow.height / 6)
        width: Math.round(Math.min(mainWindow.width, mainWindow.height) / 10 * 9)
        contentHeight: aboutColumn.height

        modal: true
        focus: true
        closePolicy: Dialog.CloseOnEscape

        ColumnLayout {
            id: aboutColumn
            x: parent.x
            width: parent.width
            spacing: 20

            Image {
                source: "PineScaleQML.svg"
                scale: mainWindow.width / 360
                ColumnLayout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                fillMode: Image.PreserveAspectFit
                //ColumnLayout.bottomMargin: 20
            }

            Label {
                text: "<html><head/><body><p>PineScaleQML developed by Presire<br> \
                       <a href=\"https://github.com/presire\">Visit Presire Github</a></p></body></html>"
                width: aboutDialog.availableWidth

                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                ColumnLayout.fillWidth: true
                ColumnLayout.fillHeight: true
                //ColumnLayout.bottomMargin: 20
                scale: mainWindow.width / 360
            }

            Button {
                id: aboutDialogButton
                text: "Close"

                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 5
                highlighted : true
                scale: mainWindow.width / 360

                Connections {
                    target: aboutDialogButton
                    function onClicked() {
                        aboutDialog.close()
                    }
                }
            }
        }
    }

    Dialog {
        id: aboutQtDialog
        title: "about Qt"
        x: 0
        y: 0
        width: mainWindow.width
        height: mainWindow.height

        modal: true
        focus: true
        closePolicy: Dialog.CloseOnEscape

        ScrollView {
            anchors.fill: parent

            ColumnLayout {
                id: aboutQtColumn
                x: aboutQtDialog.x
                width: aboutQtDialog.width
                spacing: 20

                ColumnLayout.topMargin: 10
                ColumnLayout.bottomMargin: 10

                Image {
                    source: "Qt.svg"
                    ColumnLayout.alignment: Qt.AlignTop | Qt.AlignHCenter
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: aboutQtLabel
                    textFormat: Label.RichText
                    text: "<html><head/><body><p><h2>About Qt</h2><br> \
                        <br> \
                        This program uses Qt version 5.15.2.<br>
                        Qt is a C++ toolkit for cross-platform application development.<br>
                        Qt provides single-source portability across all major desktop operating systems.<br>
                        It is also available for embedded Linux and other embedded and <br>
                        mobile operating systems.<br>
                        <br>
                        Qt is available under multiple licensing options designed to accommodate the needs <br>
                        of our various users.<br>
                        <br>
                        Qt licensed under our commercial license agreement is appropriate for development <br>
                        of proprietary/commercial software where you do not want to share any source code <br>
                        with third parties or otherwise cannot comply with the terms of GNU (L)GPL.<br>
                        <br>
                        Qt licensed under GNU (L)GPL is appropriate for the development of Qt applications <br>
                        provided you can comply with the terms and conditions of the respective licenses.<br>
                        <br>
                        Please see <a href=\"http://qt.io/licensing/\">qt.io/licensing</a> for an overview of Qt licensing.<br>
                        <br>
                        Copyright (C) 2021 The Qt Company Ltd and other contributors.<br>
                        Qt and the Qt logo are trademarks of The Qt Company Ltd.<br>
                        <br>
                        Qt is The Qt Company Ltd product developed as an open source project.<br>
                        See <a href=\"http://qt.io/\">qt.io</a> for more information.</p></body></html>"
                    width: aboutQtDialog.availableWidth

                    ColumnLayout.fillWidth: true
                    ColumnLayout.fillHeight: true

                    onLinkActivated: {
                        Qt.openUrlExternally(link)
                    }
                }

                Button {
                    id: aboutQtDialogBtn
                    text: "Close"

                    Layout.alignment: Qt.AlignHCenter
                    Layout.bottomMargin: 20
                    highlighted : true
                    scale: mainWindow.width / 360

                    Connections {
                        target: aboutQtDialogBtn
                        function onClicked() {
                            aboutQtDialog.close()
                        }
                    }
                }
            }
        }
    }
}


