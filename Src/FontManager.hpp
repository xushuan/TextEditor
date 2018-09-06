#pragma once

#include <QObject>

class FontManager : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString iconFont READ iconFont NOTIFY iconFontChanged)

public:
    explicit FontManager(QObject *parent = nullptr);

    const QString iconFont() const { return mIconFont; }

signals:
    void iconFontChanged();

private:
    void loadFontFamilyFromTTF(const QString &fontFile, QString &fontStr);

private:
    // 图标字体文件
    QString mIconFont;
};
