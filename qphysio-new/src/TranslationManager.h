#pragma once
#include <QObject>
#include <QDebug>
#include <QTranslator>
#include <QGuiApplication>


class TranslationManager : public QObject {
    Q_OBJECT
    
public:
    explicit TranslationManager(QObject *parent = nullptr) {}

    Q_INVOKABLE void switchLanguage(const QString &languageCode) {
        qApp->removeTranslator(&translator_);
        QString file = "../translations/app_" + languageCode + ".qm";
        if (!translator_.load(file)) { qWarning() << "Failed to load translation:" << file; }
        qApp->installTranslator(&translator_);
        emit languageChanged();
    }

signals:
    void languageChanged();

private:
    QTranslator translator_;
};
