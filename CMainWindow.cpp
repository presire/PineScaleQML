#include "CMainWindow.h"

CMainWindow::CMainWindow(QObject *parent) : QObject(parent)
{
    m_strIniFilePath = QCoreApplication::applicationDirPath() + QDir::separator() + tr("settings.ini");
}

int CMainWindow::getMainWindowWidth()
{
    QSettings settings(m_strIniFilePath, QSettings::IniFormat, this);

    settings.beginGroup("MainWindow");

    int iMainWindowWidth = 720;

    if(settings.contains("Width"))
    {
        iMainWindowWidth = settings.value("Width").toInt();
    }

    settings.endGroup();

    return iMainWindowWidth;
}

int CMainWindow::getMainWindowHeight()
{
    QSettings settings(m_strIniFilePath, QSettings::IniFormat, this);

    settings.beginGroup("MainWindow");

    int iMainWindowHeight = 1440;

    if(settings.contains("Height"))
    {
        iMainWindowHeight = settings.value("Height").toInt();
    }

    settings.endGroup();

    return iMainWindowHeight;
}

int CMainWindow::setMainWindowState(int X, int Y, int Width, int Height, bool Maximized)
{
    int iRet = 0;

    try
    {
        QSettings settings(m_strIniFilePath, QSettings::IniFormat, this);

        settings.beginGroup("MainWindow");
        settings.setValue("X", X);
        settings.setValue("Y", Y);
        settings.setValue("Width", Width);
        settings.setValue("Height", Height);
        if(Maximized)
        {
            settings.setValue("Maximized", "true");
        }
        else
        {
            settings.setValue("Maximized", "false");
        }

        settings.endGroup();
    }
    catch (QException *ex)
    {
        iRet = -1;
    }

    return iRet;
}

QString CMainWindow::getCurrentScale(int iCurrentWidth)
{
    // Get Screen Transform
    QString strScriptPath = QCoreApplication::applicationDirPath() + QDir::separator() + tr("GetTransform.sh");
    QProcess process(this);
    process.execute(strScriptPath, QStringList());

    // Read Screen Transform Value
    QString strResultPath = QCoreApplication::applicationDirPath() + QDir::separator() + tr("transform.txt");
    QFile File(strResultPath);

    // If Script's Result File exist, Read File Data.
    int iTransform = 0;
    if(File.exists())
    {
        File.open(QIODevice::ReadOnly);
        QByteArray byaryTransform = File.readAll();
        iTransform = QString(byaryTransform.toStdString().c_str()).toInt(nullptr, 10);

        // File Close
        File.close();

        // Delete File
        File.remove(strResultPath);
    }

    double dCurrentScale = 0.0f;
    if (iTransform == 0 || iTransform == 180)
    {
        dCurrentScale = static_cast<double>(720 / (double)iCurrentWidth);
    }
    else
    {
        dCurrentScale = static_cast<double>(1440 / (double)iCurrentWidth);
    }

    QString strCurrentSale = QString::number(dCurrentScale);
    int iDecimalPoint = strCurrentSale.indexOf(".", 0);
    QString strRoundCurrentScale = strCurrentSale.mid(0, iDecimalPoint + 3);

    return strRoundCurrentScale;
}

void CMainWindow::onClickedScale_2_0()
{
    QStringList Args = QStringList() << tr("--output=DSI-1") << tr("--scale=2");
    QProcess process;
    process.execute(tr("/usr/bin/wlr-randr"), Args);
    process.close();
}

void CMainWindow::onClickedScale_1_75()
{
    QStringList Args = QStringList() << tr("--output=DSI-1") << tr("--scale=1.75");
    QProcess process;
    process.execute(tr("/usr/bin/wlr-randr"), Args);
    process.close();
}

void CMainWindow::onClickedScale_1_5()
{
    QStringList Args = QStringList() << tr("--output=DSI-1") << tr("--scale=1.5");
    QProcess process;
    process.execute(tr("/usr/bin/wlr-randr"), Args);
    process.close();
}

void CMainWindow::onClickedScale_1_25()
{
    QStringList Args = QStringList() << tr("--output=DSI-1") << tr("--scale=1.25");
    QProcess process;
    process.execute(tr("/usr/bin/wlr-randr"), Args);
    process.close();
}

void CMainWindow::onClickedScale_1_0()
{
    QStringList Args = QStringList() << tr("--output=DSI-1") << tr("--scale=1");
    QProcess process;
    process.execute(tr("/usr/bin/wlr-randr"), Args);
    process.close();
}

void CMainWindow::onClickedPhosh(QString strPassword)
{
    QStringList Args = QStringList() << tr("-c") << tr("echo ") + strPassword + tr(" | sudo -S systemctl restart phosh");
    QProcess process;
    process.execute(tr("/bin/sh"), Args);
    process.close();
}

void CMainWindow::onClickedClose(QString strPassword)
{
    savePassword(strPassword);
}

int CMainWindow::savePassword(QString strPassword)
{
    if(strPassword.isEmpty())
    {
        return 0;
    }

    QString strFilePath = QCoreApplication::applicationDirPath() + QDir::separator() + tr("Password.txt");

    try
    {
        // Encrypt Password
        CAES AES("");
        QByteArray ByAryEncriptData = AES.Crypt(strPassword.toUtf8());

        QFile File(strFilePath);
        File.open(QIODevice::WriteOnly);

        // If Password File exist, File Data truncate.
        if(File.exists())
        {
            File.resize(strFilePath, 0);
        }

        // Write Data to File
        File.write(ByAryEncriptData);

        // File Close
        File.close();
    }
    catch(QException *e)
    {
        return -1;
    }

    return 0;
}

QString CMainWindow::getPassword()
{
    QString strFilePath = QCoreApplication::applicationDirPath() + QDir::separator() /*strExecutePath*/ + tr("Password.txt");
    QString strPassword = tr("");

    QFile File(strFilePath);
    if(!File.exists())
    {
        // Create Empty Password File
        try
        {
            File.open(QIODevice::WriteOnly);

            File.write(nullptr);

            File.close();
        }
        catch(QException *e)
        {
            return QString(e->what());
        }

        return tr("");
    }
    else
    {
        try
        {
            File.open(QIODevice::ReadOnly);

            QByteArray ByAryEncryptPassword = File.readLine();

            // Decrypt Password
            CAES AES("");
            QByteArray ByAryDecryptData = AES.DeCrypt(ByAryEncryptPassword);

            strPassword = ByAryDecryptData.toStdString().c_str();
            strPassword = strPassword.replace(" ", "", Qt::CaseSensitive);

            File.close();
        }
        catch(QException *e)
        {

        }
    }

    return strPassword;
}

bool CMainWindow::getColorMode()
{
    QSettings settings(m_strIniFilePath, QSettings::IniFormat, this);

    settings.beginGroup("MainWindow");

    bool bDarkMode = false;
    if(settings.contains("DarkMode"))
    {
        bDarkMode = settings.value("DarkMode").toBool();
    }

    settings.endGroup();

    return bDarkMode;
}


int CMainWindow::setColorMode(bool bDarkMode)
{
    int iRet = 0;

    try
    {
        QSettings settings(m_strIniFilePath, QSettings::IniFormat, this);

        settings.beginGroup("MainWindow");

        if(bDarkMode)
        {
            settings.setValue("DarkMode", "true");
        }
        else
        {
            settings.setValue("DarkMode", "false");
        }

        settings.endGroup();
    }
    catch (QException *ex)
    {
        iRet = -1;
    }

    return iRet;
}

QString CMainWindow::getVersion()
{
    return QString(VER);
}
