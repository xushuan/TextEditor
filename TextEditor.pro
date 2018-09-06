QT += quick quickcontrols2
qtHaveModule(widgets): QT += widgets

cross_compile: DEFINES += QT_EXTRA_FILE_SELECTOR=\\\"touch\\\"

CONFIG += c++11

TEMPLATE = app
TARGET = texteditor

HEADERS += \
    Src/FontManager.hpp \
    Src/DocumentHandler.hpp

SOURCES += \
    Src/main.cpp \
    Src/FontManager.cpp \
    Src/DocumentHandler.cpp

RESOURCES += qml.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols2/texteditor
INSTALLS += target
