#pragma once
#include <QObject>
#include <QSettings>
#include <QString>
#include <QColor>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>

#define JSON_APPLICATION_REVISION_DATA "../src/Revisions.json"

// This logic should be replaced with the display driver data
inline constexpr int applicationScreenWidth = 1024;
inline constexpr int applicationScreenHeight = 600;

inline constexpr const char *screenBlueColor = "#1a91ff";
inline constexpr const char *screenWhiteColor = "#ffffff";
inline constexpr const char *screenBlueHalfTransparentColor = "#66b6ff";


class ApplicationSettings : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString password READ getPassword WRITE setPassword NOTIFY passwordChanged)
    Q_PROPERTY(QString language READ getLanguage WRITE setLanguage NOTIFY languageChanged)
    Q_PROPERTY(uint32_t totalTimeInSec READ getTotalTimeInSec WRITE setTotalTimeInSec NOTIFY totalTimeInSecChanged)

    // Constant properties
    Q_PROPERTY(int screenWidth READ getScreenWidth CONSTANT)
    Q_PROPERTY(int screenHeight READ getScreenHeight CONSTANT)
    Q_PROPERTY(double MBSoftRev READ getMBSoftRev CONSTANT)
    Q_PROPERTY(double IOSoftRev READ getIOSoftRev CONSTANT)
    Q_PROPERTY(double MBHardRev READ getMBHardRev CONSTANT)
    Q_PROPERTY(double IOHardRev READ getIOHardRev CONSTANT)
    Q_PROPERTY(QColor screenBlueColor READ getScreenBlueColor CONSTANT)
    Q_PROPERTY(QColor screenWhiteColor READ getScreenWhiteColor CONSTANT)
    Q_PROPERTY(QColor screenBlueHalfTransparentColor READ getScreenBlueHalfTransparentColor CONSTANT)

public:
    explicit ApplicationSettings(QObject *parent = nullptr);


    QString getPassword() const;
    void setPassword(const QString &pwd);

    QString getLanguage() const;
    void setLanguage(const QString &lang);

    uint32_t getTotalTimeInSec() const;
    void setTotalTimeInSec(const uint32_t &timeInSec);

    int getScreenWidth() const { return applicationScreenWidth; } 
    int getScreenHeight() const { return applicationScreenHeight; }

    double getMBSoftRev() { return getRevisionField("MBSoftwareRevision"); } 
    double getIOSoftRev() { return getRevisionField("IOSoftwareRevision"); }
    double getMBHardRev() { return getRevisionField("MBHardwareRevision"); }
    double getIOHardRev() { return getRevisionField("IOHardwareRevision"); }

    QColor getScreenBlueColor() const { return QColor(screenBlueColor); }
    QColor getScreenWhiteColor() const { return QColor(screenWhiteColor); }
    QColor getScreenBlueHalfTransparentColor() const { return QColor(screenBlueHalfTransparentColor); }

    Q_INVOKABLE void load();
    Q_INVOKABLE void save();

signals:
    void passwordChanged();
    void languageChanged();
    void totalTimeInSecChanged();

private:
    QSettings settings_;

    QString password_; 
    QString language_; 
    uint32_t totalTimeInSec_;

    QJsonValue getJsonField(const char *st) {
        QFile jsonFile(JSON_APPLICATION_REVISION_DATA);

        if (!jsonFile.open(QIODevice::ReadOnly)) {
            qWarning() << "Cannot open json file";
            return -1;
        }

        QByteArray data = jsonFile.readAll();
        jsonFile.close();

        QJsonParseError parseError;
        QJsonDocument doc = QJsonDocument::fromJson(data, &parseError);
        
        if (parseError.error != QJsonParseError::NoError) {
            qWarning() << "JSON parse error: " << parseError.errorString();
            return -1;
        }

        if (!doc.isObject()) {
            qWarning() << "JSON is not an object!";
            return -1;
        }

        QJsonObject obj = doc.object();
        return obj.value(st);
    }

    double getRevisionField(const char *st) { return getJsonField(st).toDouble(); }
    double getScreenDimensionField(const char *st) { return getJsonField(st).toInt(); }
};
