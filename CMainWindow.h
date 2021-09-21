#ifndef CMAINWINDOW_H
#define CMAINWINDOW_H

#include <QCoreApplication>
#include <QProcess>
#include <QDir>
#include <QFile>
#include <QException>
#include <QObject>
#include "CAES.h"

class CMainWindow : public QObject
{
    Q_OBJECT

public:
    explicit CMainWindow(QObject *parent = nullptr);

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

signals:

};

#endif // CMAINWINDOW_H
