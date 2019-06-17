#include <QDebug>
#include <QDir>
#include <QSettings>
#include <QString>

#include "modules/core/dispatcher/dispatcherMacro.h"
#include "modules/pages/listProjects/presenter/listProjects.h"
#include "modules/pages/listProjects/presenter/listProjectsMacro.h"
#include "util/cpp/QtUtil.h"

using namespace std;

ListProjects::ListProjects(QObject* parent)
{
}

void ListProjects::getAllProjects(QVariant templateName)
{
    QStringList projects = QtUtil::getAllKeys(ORGANIZATION, PROJECTS, templateName.toString());
    emit projectsReady(projects);
}
