import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.15
import Qt.labs.settings 1.1
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Universal 2.15
import MainWindow 1.0

ApplicationWindow {
    id: mainWindow
    x: 0
    y: 0
    width: mainWindowModel.getMainWindowWidth()
    height: mainWindowModel.getMainWindowHeight()
    visible: true
    visibility: Window.Maximized
    color: Qt.rgba(255, 255, 255, 1)

    CMainWindow {
        id: mainWindowModel;
    }

    Shortcut {
        sequence: "Esc"
        onActivated: {
            if(stackView.depth > 1)
            {
                for(let i = stackView.depth; i > 1; i--)
                {
                    stackView.pop()
                }

                actionAboutPineScaleQML.enabled = true
                actionAboutQt.enabled = true
            }
        }
    }

    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: {
            quitDialog.open()
        }
    }

    // Color Mode
    Settings {
        id: settings
        property string style: mainWindowModel.getColorMode() ? "Material" : "Universal"
    }

    function saveApplicationState() {
        // Save window state
        let bMaximized = false
        if(mainWindow.visibility === Window.Maximized)
        {
            bMaximized = true;
        }

        mainWindowModel.setMainWindowState(x, y, width, height, bMaximized)

        // Save color mode
        if (settings.style === "Material")
        {
            mainWindowModel.setColorMode(true);
        }
        else
        {
            mainWindowModel.setColorMode(false);
        }
    }

    // MenuBar
    header: MenuBar {
        id: mainMenu
        x: 0
        y: 0
        width: mainWindow.width
        font.pixelSize: 16

        // [File] Menu
        Menu {
            title: qsTr("&File(&F)")
            font.pixelSize: 16

            // [Quit] SubMenu
            Action {
                id: actionQuit
                text: "Quit(&O)"
                onTriggered: {
                    quitDialog.open();
                }
            }
        }

        // [Mode] Menu
        Menu {
            title: qsTr("Mode(&M)")

            // [Save Password] SubMenu
            Action {
                id: darkMode
                text: "Dark Mode(&D)"

                onTriggered: {
                    darkModeDialog.open();
                }
            }
        }

        // [Help] Menu
        Menu {
            title: qsTr("&Help(&H)")
            font.pixelSize: 16

            // [about PineScaleQML] SubMenu
            Action {
                id: actionAboutPineScaleQML
                text: "about PineScaleQML(&A)"
                onTriggered: {
                    stackView.pop()
                    stackView.push("aboutPineScaleQML.qml")

                    actionAboutPineScaleQML.enabled = false
                    actionAboutQt.enabled = true
                }
            }

            // [about Qt] SubMenu
            Action {
                id: actionAboutQt
                text: "about Qt(&t)"
                onTriggered: {
                    stackView.pop()
                    stackView.push("aboutQt.qml")

                    actionAboutPineScaleQML.enabled = true
                    actionAboutQt.enabled = false
                }
            }
        }
    }

    StackView {
        id: stackView
        x: 0
        y: mainMenu.height
        width: mainWindow.width
        height: mainWindow.height - mainMenu.height
        initialItem: "scale.qml"
        anchors.fill: parent
    }


    Dialog {
        id: darkModeDialog
        title: "Dark Mode"
        x: 0
        y: Math.round(mainWindow.height / 6)
        width: mainWindow.width
        contentHeight: darkModeColumn.height

        modal: true
        focus: true
        closePolicy: Dialog.CloseOnEscape

        property bool bRestart: false

        onClosed: {
            if (!darkModeDialog.bRestart)
            {
                themeSwitch.checked = mainWindowModel.getColorMode();
            }
        }

        ColumnLayout {
            id: darkModeColumn
            width: parent.width
            spacing: 20

            Label {
                text: "When you restart this software, the color will change."
                wrapMode: Label.WordWrap
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.bottomMargin: 20
            }

            Switch {
                id: themeSwitch
                text: "Dark"
                checked: mainWindowModel.getColorMode() ? true : false
                Layout.alignment: Qt.AlignHCenter

                onCheckedChanged: {
                    let bDarkMode = mainWindowModel.getColorMode();
                    if (bDarkMode !== themeSwitch.checked)
                    {
                        darkModeRestartBtn.enabled = true;
                    }
                    else
                    {
                        darkModeRestartBtn.enabled = false;
                    }
                }
            }

            RowLayout {
                width: parent.width
                Layout.alignment: Qt.AlignHCenter
                spacing: 20

                Button {
                    id: darkModeRestartBtn
                    text: "Application Quit"
                    enabled: false

                    Connections {
                        target: darkModeRestartBtn
                        function onClicked() {
                            darkModeDialog.bRestart = true;

                            if (themeSwitch.checked)
                            {
                                settings.style = "Material";
                                mainWindowModel.setColorMode(true);
                            }
                            else
                            {
                                settings.style = "Universal";
                                mainWindowModel.setColorMode(false);
                            }

                            //mainWindowModel.restartSoftware();

                            Qt.quit();
                        }
                    }
                }

                Button {
                    id: darkModeCancelBtn
                    text: "Cancel"

                    Connections {
                        target: darkModeCancelBtn
                        function onClicked() {
                            darkModeDialog.close();
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
        y: Math.round(mainWindow.height / 6)
        width: mainWindow.width
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
                            // Save Window State
                            saveApplicationState()
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


