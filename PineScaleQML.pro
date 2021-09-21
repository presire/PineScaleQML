QT += quick quickcontrols2

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        CAES.cpp \
        CMainWindow.cpp \
        main.cpp

RESOURCES += \
            qml.qrc \
            PineScale.svg \
            Qt.svg

HEADERS += \
    CAES.h \
    CMainWindow.h

DISTFILES += \
    PineScale.svg \
    Qt.svg

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /home/mobian/InstallSoftware/$${TARGET}
#!isEmpty(target.path): INSTALLS += target

isEmpty(PREFIX) {
    PREFIX = /$${PWD}/$${TARGET}
}

target.path = $${PREFIX}/
INSTALLS += target
