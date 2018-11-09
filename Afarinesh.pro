############### General ###############
QT += qml quick quickcontrols2 widgets
CONFIG += c++11

############### Compiler Flgas ###############
DEFINES += QT_DEPRECATED_WARNINGS

############### Resources ###############
SOURCES += $$files(modules/*.cpp, true) \
           $$files(util/cpp/*.cpp, true)

HEADERS += $$files(modules/*.h, true) \
           $$files(util/cpp/*.h, true)

RESOURCES += qml.qrc

############### Deployment ###############
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

unix: CONFIG += link_pkgconfig
unix: PKGCONFIG += glib-2.0
