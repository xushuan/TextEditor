#ifdef QT_WIDGETS_LIB
#include <QApplication>
#else
#include <QGuiApplication>
#endif
#include <QQmlApplicationEngine>

#include <QDebug>
#include <QFontDatabase>
#include <QQmlContext>
#include <QQmlFileSelector>

#include "FontManager.hpp"
#include "DocumentHandler.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Text Editor");
    QGuiApplication::setOrganizationName("QtProject");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#ifdef QT_WIDGETS_LIB
    QApplication app(argc, argv);
#else
    QGuiApplication app(argc, argv);
#endif

    qmlRegisterType<DocumentHandler>("io.qt.examples.texteditor", 1, 0, "DocumentHandler");

    QStringList selectors;
#ifdef QT_EXTRA_FILE_SELECTOR
    selectors += QT_EXTRA_FILE_SELECTOR;
#else
    if (app.arguments().contains("-touch"))
        selectors += "touch";
#endif

    FontManager fontManager;
    QQmlApplicationEngine engine;
    QQmlFileSelector::get(&engine)->setExtraSelectors(selectors);
    engine.rootContext()->setContextProperty("FontManager", &fontManager);

    engine.load(QUrl("qrc:/Qml/main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
