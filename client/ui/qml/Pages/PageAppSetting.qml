import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import PageEnum 1.0
import "./"
import "../Controls"
import "../Config"

PageBase {
    id: root
    page: PageEnum.AppSettings
    logic: AppSettingsLogic

    BackButton {
        id: back
    }
    Caption {
        id: caption
        text: qsTr("Application Settings")
    }

    Flickable {
        id: fl
        width: root.width
        anchors.top: caption.bottom
        anchors.topMargin: 20
        anchors.bottom: logo.top
        anchors.bottomMargin: 20
        anchors.left: root.left
        anchors.leftMargin: 30
        anchors.right: root.right
        anchors.rightMargin: 30

        contentHeight: content.height
        clip: true

        ColumnLayout {
            id: content
            enabled: logic.pageEnabled
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            CheckBoxType {
                visible: !GC.isMobile()
                Layout.fillWidth: true
                text: qsTr("Auto connect")
                checked: AppSettingsLogic.checkBoxAutoConnectChecked
                onCheckedChanged: {
                    AppSettingsLogic.checkBoxAutoConnectChecked = checked
                    AppSettingsLogic.onCheckBoxAutoconnectToggled(checked)
                }
            }
            CheckBoxType {
                visible: !GC.isMobile()
                Layout.fillWidth: true
                text: qsTr("Auto start")
                checked: AppSettingsLogic.checkBoxAutostartChecked
                onCheckedChanged: {
                    AppSettingsLogic.checkBoxAutostartChecked = checked
                    AppSettingsLogic.onCheckBoxAutostartToggled(checked)
                }
            }
            CheckBoxType {
                visible: !GC.isMobile()
                Layout.fillWidth: true
                text: qsTr("Start minimized")
                checked: AppSettingsLogic.checkBoxStartMinimizedChecked
                onCheckedChanged: {
                    AppSettingsLogic.checkBoxStartMinimizedChecked = checked
                    AppSettingsLogic.onCheckBoxStartMinimizedToggled(checked)
                }
            }
            LabelType {
                Layout.fillWidth: true
                Layout.topMargin: 15
                text: AppSettingsLogic.labelVersionText
            }
            BlueButtonType {
                visible: !GC.isMobile()
                Layout.fillWidth: true
                Layout.preferredHeight: 41
                text: qsTr("Check for updates")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/amnezia-vpn/desktop-client/releases/latest")
                }
            }

            CheckBoxType {
                Layout.fillWidth: true
                Layout.topMargin: 15
                text: qsTr("Keep logs")
                checked: AppSettingsLogic.checkBoxSaveLogsChecked
                onCheckedChanged: {
                    AppSettingsLogic.checkBoxSaveLogsChecked = checked
                    AppSettingsLogic.onCheckBoxSaveLogsCheckedToggled(checked)
                }
            }
            BlueButtonType {
                Layout.fillWidth: true
                Layout.preferredHeight: 41
                text: qsTr("Open logs folder")
                onClicked: {
                    AppSettingsLogic.onPushButtonOpenLogsClicked()
                }
            }

            BlueButtonType {
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.preferredHeight: 41
                text: qsTr("Export logs")
                onClicked: {
                    AppSettingsLogic.onPushButtonExportLogsClicked()
                }
            }

            BlueButtonType {
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.preferredHeight: 41

                property string start_text: qsTr("Clear logs")
                property string end_text: qsTr("Cleared")
                text: start_text

                Timer {
                    id: timer
                    interval: 1000; running: false; repeat: false
                    onTriggered: parent.text = parent.start_text
                }
                onClicked: {
                    text = end_text
                    timer.running = true
                    AppSettingsLogic.onPushButtonClearLogsClicked()
                }
            }

            LabelType {
                Layout.fillWidth: true
                Layout.topMargin: 30
                text: qsTr("Backup and restore configuration")
            }

            BlueButtonType {
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.preferredHeight: 41
                text: qsTr("Backup app config")
                onClicked: {
                    AppSettingsLogic.onPushButtonBackupAppConfigClicked()
                }
            }
            BlueButtonType {
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.preferredHeight: 41
                text: qsTr("Restore app config")
                onClicked: {
                    AppSettingsLogic.onPushButtonRestoreAppConfigClicked()
                }
            }
        }
    }

    Logo {
        id: logo
        anchors.bottom: parent.bottom
    }
}
