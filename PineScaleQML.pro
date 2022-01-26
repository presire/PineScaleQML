lessThan(QT_MAJOR_VERSION, 5) {
   lessThan(QT_MINOR_VERSION, 15) {
      error("Sorry, you need at least Qt version 5.15.0")
      message( "You use Qt version" $$[QT_VERSION] )
   }
}

# Version Information
VERSION = 1.1.0
VERSTR = '\\"$${VERSION}\\"'  # place quotes around the version string
DEFINES += VER=\"$${VERSTR}\" # create a VER macro containing the version string

QT += quick quickcontrols2 widgets

CONFIG += c++17

# Config optimization
CONFIG(release, debug|release) {
    CONFIG += optimize_full
}

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        CAES.cpp \
        CMainWindow.cpp \
        CRunnable.cpp \
        main.cpp

HEADERS += \
    CAES.h \
    CMainWindow.h \
    CRunnable.h

RESOURCES += \
            qml.qrc \
            Image/PineScaleQML.png \
            Image/PineScaleQML.svg \
            Image/Qt.svg

DISTFILES += \
    Image/PineScaleQML.png \
    Image/PineScaleQML.svg \
    Image/Qt.svg

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /home/mobian/InstallSoftware/$${TARGET}
#!isEmpty(target.path): INSTALLS += target

# Config Install directory
isEmpty(PREFIX) {
    PREFIX = $${PWD}/$${TARGET}
}

# Create Desktop Entry file
system([ ! -d Applications ] && mkdir Applications)
system([ -f Applications/PineScaleQML.desktop ] && rm -rf Applications/PineScaleQML.desktop)
system(touch Applications/PineScaleQML.desktop)

system(echo "[Desktop Entry]" >> Applications/PineScaleQML.desktop)
system(echo "Type=Application" >> Applications/PineScaleQML.desktop)
system(echo "Name=PineScaleQML $${VERSION}" >> Applications/PineScaleQML.desktop)
system(echo "GenericName=PineScaleQML" >> Applications/PineScaleQML.desktop)
system(echo "Comment=Screen Scaling Tool for PinePhone" >> Applications/PineScaleQML.desktop)
system(echo "Exec=$${PREFIX}/PineScaleQML %F" >> Applications/PineScaleQML.desktop)
system(echo "Icon=$${PREFIX}/Image/PineScaleQML.png" >> Applications/PineScaleQML.desktop)
system(echo "Categories=Utility\;" >> Applications/PineScaleQML.desktop)
system(echo "Keywords=scaling\;screen\;pinephone\;" >> Applications/PineScaleQML.desktop)
system(echo "Terminal=false" >> Applications/PineScaleQML.desktop)

# Add Execute Permission for Shell Script
system(chmod u+x GetTransform.sh)

# Config Install file
target.path = $${PREFIX}

Script.path = $${PREFIX}
Script.files = GetTransform.sh

Image.path = $${PREFIX}/Image
Image.files = Image/PineScaleQML.png Image/PineScaleQML.svg Image/Qt.svg

Applications.path = $${PREFIX}
Applications.files = Applications/PineScaleQML.desktop

INSTALLS += target Script Image Applications
