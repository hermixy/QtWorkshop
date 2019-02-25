#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "qttshelper.hpp"
#include "uploader.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("A-Team");
    app.setOrganizationDomain("a-team.fr");
    app.setApplicationName("QtWorkshop");

    qmlRegisterType<QTTSHelper>("fr.ateam.tts", 1, 0, "TTS");
    QQmlApplicationEngine engine;
    Uploader uploader;
    engine.rootContext()->setContextProperty("uploader", &uploader);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
