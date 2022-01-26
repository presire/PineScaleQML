#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QIcon>
#include "CRunnable.h"
#include "CMainWindow.h"


int main(int argc, char *argv[])
{
    // Disable multiple activation
    CRunnable Runnable("PineScaleQML-IDBFE-L9GRV-BJNV2-HDFNM-YQFLJ");
    if (!Runnable.tryToRun())
    {
        qDebug() << "PineScaleQML is already running.";
        return -1;
    }

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);
    
    QApplication::setOrganizationName("Presire");
    
    // Set PineScaleQML Icon
    app.setWindowIcon(QIcon(":/Image/PineScaleQML.png"));

    QSettings settings;
    CMainWindow mainWindow;
    bool bColorMode = mainWindow.getColorMode();
    if (bColorMode)
    {
        QQuickStyle::setStyle("Material");
    }
    else
    {
        QQuickStyle::setStyle("Universal");
    }

    // メイン画面のコア処理
    qmlRegisterType<CMainWindow>("MainWindow", 1, 0, "CMainWindow");

    QQmlApplicationEngine engine;

    // メイン画面のコア処理
    //CMainWindow MainWindow;
    //engine.rootContext()->setContextProperty("MainWindow", &MainWindow);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
