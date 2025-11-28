#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QLocale>
#include <QCursor>
#include "ApplicationSettings.h"
#include "TranslationManager.h"
#include <QQmlContext>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    static ApplicationSettings settingsInstance;

    qmlRegisterSingletonInstance(
        "App", 1, 0,
        "ApplicationSettings",
        &settingsInstance
    );

    QQmlApplicationEngine engine;
    TranslationManager translatorInstance(&engine);
    engine.rootContext()->setContextProperty("TranslationManager", &translatorInstance);
    QObject::connect(
            &translatorInstance, &TranslationManager::languageChanged, [&engine](){
            engine.retranslate();
    });
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("QPhysio", "Main");

    return app.exec();
}
