#include "ApplicationSettings.h"
#include <QDebug>

ApplicationSettings::ApplicationSettings(QObject *parent)
    : QObject(parent),
    settings_("TeleaMedical", "Q-Physio")
{
}


QString ApplicationSettings::getPassword() const {
    return password_;
}

void ApplicationSettings::setPassword(const QString &pwd) {
    if (password_ == pwd) return;
    password_ = pwd;
    emit passwordChanged();
}

QString ApplicationSettings::getLanguage() const {
    return language_;
}

void ApplicationSettings::setLanguage(const QString &lang) {
    if (language_ == lang) return;
    language_ = lang;
    emit languageChanged();
}

uint32_t ApplicationSettings::getTotalTimeInSec() const {
    return totalTimeInSec_;
}

void ApplicationSettings::setTotalTimeInSec(const uint32_t &timeInSec) {
    if (totalTimeInSec_ == timeInSec) return;
    totalTimeInSec_ = timeInSec;
    emit totalTimeInSecChanged();
}

void ApplicationSettings::load() {
    int configVersion = settings_.value("Config/version", -1).toInt();

    if (configVersion == -1) {
        password_ = "11111";
        language_ = "en";
        totalTimeInSec_ = 0;

        settings_.setValue("User/password", password_);
        settings_.setValue("User/language", language_);
        settings_.setValue("User/totalTimeInSec", totalTimeInSec_);

        settings_.setValue("Config/version", 1);

        emit passwordChanged();
        emit languageChanged();
        emit totalTimeInSecChanged();

        return;
    }

    password_ = settings_.value("User/password", "").toString();
    language_ = settings_.value("User/language", "").toString();
    totalTimeInSec_ = settings_.value("User/totalTimeInSec", 0).toInt();

    emit passwordChanged();
    emit languageChanged();
    emit totalTimeInSecChanged();
}

void ApplicationSettings::save() {
    settings_.setValue("User/password", password_);
    settings_.setValue("User/language", language_);
    settings_.setValue("User/totalTimeInSec", totalTimeInSec_);
}

