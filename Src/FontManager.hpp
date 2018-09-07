#pragma once

#include <QObject>

class FontManager : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString iconFont READ iconFont NOTIFY iconFontChanged)
    Q_PROPERTY(QString andaleFont READ andaleFont NOTIFY andaleFontChanged)
    Q_PROPERTY(QString siyuanFont READ siyuanFont NOTIFY siyuanFontChanged)

public:
    explicit FontManager(QObject *parent = nullptr);

    const QString iconFont() const { return mIconFont; }
    const QString andaleFont() const { return mAndaleMono; }
    const QString siyuanFont() const { return mSiYuanRegular; }

signals:
    void iconFontChanged();
    void andaleFontChanged();
    void siyuanFontChanged();

private:
    void loadFontFamilyFromTTF(const QString &fontFile, QString &fontStr);

private:
    // 图标字体文件
    QString mIconFont;
    QString mAndaleMono;
    QString mSiYuanRegular;
};
