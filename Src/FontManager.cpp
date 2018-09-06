#include "FontManager.hpp"

#include <QDebug>

#include <QFile>
#include <QFontDatabase>
#include <QCoreApplication>

FontManager::FontManager(QObject *parent) : QObject(parent) {
    QString fontPath = QCoreApplication::applicationDirPath();

    loadFontFamilyFromTTF(fontPath + "/Fonts/icomoon.ttf", mIconFont);
}

// 加载TTF字体文件
void FontManager::loadFontFamilyFromTTF(const QString &fontFile, QString &fontStr) {
    QFile file(fontFile);
    if (!file.exists()) {
        qWarning() << QString("%1 not exists").arg(fontFile);
        return;
    }

    if (file.open(QIODevice::ReadOnly)) {
        int loadedFontID = QFontDatabase::addApplicationFontFromData(file.readAll());
        QStringList loadedFontFamilies = QFontDatabase::applicationFontFamilies(loadedFontID);

        if(!loadedFontFamilies.empty()) {
            fontStr = loadedFontFamilies.at(0);
        }

        file.close();
    } else {
        qWarning() << QString("open %1 failed").arg(fontFile);
    }
}
