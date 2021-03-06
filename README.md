# PineScaleQML for PinePhone  

# Preface  
PineScaleQML is a scaling software for PinePhone.<br>
You can easily change the scaling of the screen just by pressing the scaling button.<br>
<br>
This article uses Mobian,<br>
<u>you should be able to install it on other Linux distributions as well.</u><br>
(Ex. Manjaro ARM, openSUSE TW, ... etc)<br>
<br>
PineScaleQML uses the <I>"**wlr-randr**"</I> package for screen scaling.<br>
<br>
*Note:*<br>
*PineScaleQML is created in Qt 5.15, so it requires Qt 5.15 library.*<br>
<br>

# 1. Install the necessary dependencies for PineScaleQML
You need to install Qt libraries shown below on PinePhone.<br>
* libQt5Core.so.5
* libQt5Gui.so.5
* libQt5Quick.so.5
* libQt5QuickControls2.so.5
* libQt5Qml.so.5
* libQt5QmlModels.so.5
* libQt5Network.so.5
<br>

Get the latest updates on PinePhone.<br>

    sudo apt-get update  
    sudo apt-get dist-upgrade  
<br>

Install the dependencies required to build the PineScaleQML.

    sudo apt-get install wlr-randr \
                         qt5-qmake qt5-qmake-bin \
                         libqt5core5a libqt5gui5 libqt5quick5 libqt5quickcontrols2-5 \
                         libqt5qml5 libqt5qmlmodels5 libqt5network5
<br>
<br>

# 2. Compile & Install PineScaleQML
Download the source code from PineScaleQML's Github.<br>

    git clone https://github.com/presire/PineScaleQML.git PineScaleQML
<br>

Use the qmake command to compile the source code of PineScaleQML.<br>
The default installation directory is <I>**/${PWD}/PineScaleQML**</I>.<br>

The recommended installation directory is the home directory. (Ex. <I>**${HOME}/InstallSoftware/PineScaleQML**</I>)

    cd PineScaleQML

    mkdir build && cd build

    qmake ../PineScaleQML.pro PREFIX=<The directory you want to install in>
    make -j $(nproc)
    make install
<br><br>

# 3. Copy DesktoEntry for PineScaleQML
    cd <The directory you have installed in>
    cp PineScaleQML.desktop ~/.local/share/applications
<br>

<center><img src="img/PineScaleQML_SS_2.png" width="35%" height="35%" ></center><br>
<br>
<br>

# 4. Execute PineScaleQML
Make sure you can execute **PineScaleQML**.<br>
<br>
<center><img src="img/PineScaleQML_SS_1.png" width="35%" height="35%" ></center><br>
<br>
To reboot Phosh, first, enter the Linux administrator password into text input,<br>
and press [Save Password] button.<br>
<br>
Next, press [Restart Phosh] button.
<br>
<br> 
