############### General ###############
QT += core qml quick quickcontrols2

VERSION = $$system(git log --pretty=format:'%h' -n 1)
DEFINES += APP_VER=\\\"$$VERSION\\\"
DEFINES += QT_DEPRECATED_WARNINGS

include(runtimeqml/runtimeqml.pri)
# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += "QRC_RUNTIME_SOURCE_PATH=\\\"$$PWD\\\""

############### Compiler Flgas ###############
DEFINES += QT_DEPRECATED_WARNINGS
QMAKE_CXXFLAGS_WARN_OFF -= -Wunused-parameter

############### Resources ###############
SOURCES += $$files(modules/*.cpp, true) \
           $$files(util/cpp/*.cpp, true)

HEADERS += $$files(modules/*.h, true) \
           $$files(util/cpp/*.h, true)

RESOURCES += qml.qrc

############### Other files ###############
OTHER_FILES += LICENSE\
            README.md\
            .gitignore

############### Libs ###############
unix: CONFIG += link_pkgconfig
unix: PKGCONFIG += glib-2.0 yaml-0.1

############### Deployment ###############
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


############### Make Directory into Build Directory After Build ###############
#mytarget.commands += $${QMAKE_MKDIR} $$shell_path($${OUT_PWD}/templates/QtCpp)
#first.depends = $(first) mytarget
#export(first.depends)
#export(mytarget.commands)
#QMAKE_EXTRA_TARGETS += first mytarget

################ Copy Files to Build Directory After Build ###############
#copydata.commands = $(COPY_DIR) $$PWD/templates/* $$OUT_PWD
#first.depends = $(first) copydata
#export(first.depends)
#export(copydata.commands)
#QMAKE_EXTRA_TARGETS += first copydata

#CONFIG += c++11
#QMAKE_CXXFLAGS += -std=c++17
#QMAKE_CXXFLAGS += /std:c++17
