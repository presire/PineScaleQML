#include "CMainWindow.h"

CMainWindow::CMainWindow(QObject *parent) : QObject(parent)
{

}

QString CMainWindow::getCurrentScale(int iCurrentWidth)
{
    double dCurrentScale = static_cast<double>(720 / (double)iCurrentWidth);
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
