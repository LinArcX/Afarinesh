############### General ###############
QT += core qml quick quickcontrols2 widgets
CONFIG += c++11

############### Compiler Flgas ###############
DEFINES += QT_DEPRECATED_WARNINGS

############### Resources ###############
SOURCES += $$files(modules/*.cpp, true) \
           $$files(util/cpp/*.cpp, true)

HEADERS += $$files(modules/*.h, true) \
           $$files(util/cpp/*.h, true)

RESOURCES += qml.qrc

############### Libs ###############
unix: CONFIG += link_pkgconfig
unix: PKGCONFIG += glib-2.0 yaml-0.1

############### Make Directory into Build Directory After Build ###############
mytarget.commands += $${QMAKE_MKDIR} $$shell_path($${OUT_PWD}/templates/QtCpp)
first.depends = $(first) mytarget
export(first.depends)
export(mytarget.commands)
QMAKE_EXTRA_TARGETS += first mytarget

################ Copy Files to Build Directory After Build ###############
copydata.commands = $(COPY_DIR) $$PWD/templates/* $$OUT_PWD
first.depends = $(first) copydata
export(first.depends)
export(copydata.commands)
QMAKE_EXTRA_TARGETS += first copydata



############### Deployment ###############
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
