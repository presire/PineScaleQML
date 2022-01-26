#ifndef CMAINWINDOW_H
#define CMAINWINDOW_H

#include <QCoreApplication>
#include <QObject>
#include <QSettings>
#include <QProcess>
#include <QDir>
#include <QFile>
#include <QException>
#include "CAES.h"

class CMainWindow : public QObject
{
    Q_OBJECT

private:
    QString m_strIniFilePath;

public:
    explicit CMainWindow(QObject *parent = nullptr);

    Q_INVOKABLE int     getMainWindowWidth();
    Q_INVOKABLE int     getMainWindowHeight();
    Q_INVOKABLE int     setMainWindowState(int X, int Y, int Width, int Height, bool Maximized);

    Q_INVOKABLE QString getCurrentScale(int iCurrentWidth);

    Q_INVOKABLE int     savePassword(QString strPassword);
    Q_INVOKABLE QString getPassword();

    Q_INVOKABLE void onClickedScale_2_0();
    Q_INVOKABLE void onClickedScale_1_75();
    Q_INVOKABLE void onClickedScale_1_5();
    Q_INVOKABLE void onClickedScale_1_25();
    Q_INVOKABLE void onClickedScale_1_0();
    Q_INVOKABLE void onClickedPhosh(QString strPassword);
    Q_INVOKABLE void onClickedClose(QString strPassword);

    Q_INVOKABLE bool    getColorMode();
    Q_INVOKABLE int     setColorMode(bool bDarkMode);

    Q_INVOKABLE QString getVersion();

signals:

};

#endif // CMAINWINDOW_H
