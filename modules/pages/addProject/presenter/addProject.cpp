#include <QDir>
#include <QSettings>
#include <QString>
#include <QVariant>
#include <iostream>

#include "modules/core/dispatcher/dispatcherMacro.h"
#include "modules/pages/addProject/presenter/addProject.h"
#include "modules/pages/addProject/presenter/addProjectMacro.h"
#include "util/cpp/ConvertUtil.h"
#include "util/cpp/FileUtil.h"
#include "util/cpp/QtUtil.h"
#include "util/cpp/RegexUtil.h"
#include "util/cpp/utils.h"

using namespace std;

AddProject::AddProject(QObject* parent)
{
    patternBothInFileNames = new QMap<QString, QStringList>();
    patternBothInsideFiles = new QMap<QString, QStringList>();
    patternInFileNames = new QMap<QString, QStringList>();
    patternInsideFiles = new QMap<QString, QStringList>();
}

void AddProject::getVariables(QVariant templateName)
{
    QStringList vars;

    QString rawTemplatePath = QtUtil::getValue(ORGANIZATION, APPLICATION, TEMPLATES_GROUP, templateName.toString()).toString();
    QString templatePath = QString::fromUtf8(rawTemplatePath.split("file://")[1].toStdString().c_str()) + "/templates/app";

    QStringList exceptions;
    exceptions.push_back(".otf");
    exceptions.push_back(".ttf");
    exceptions.push_back(".png");
    exceptions.push_back(".svg");
    QStringList files = FileUtil::getAllFilesInDir(templatePath, QDir::Hidden | QDir::Files, exceptions);

    for (QString file : files) {
        if (file.contains("{[")) {
            QFile f(file);
            f.open(QIODevice::ReadOnly);
            QStringList list = RegexUtil::findAllAcuurances(QString::fromStdString(f.readAll().toStdString()), "(?<={\\[).+?(?=]})");

            if (!list.isEmpty()) {
                // Inside-file-names & Inside-files
                patternBothInsideFiles->insert(file, list);

                QStringList listInFileNames = RegexUtil::findAllAcuurances(file, "(?<={\\[).+?(?=]})");
                patternBothInFileNames->insert(file, listInFileNames);

                vars.append(list);
            } else {
                // Inside-file-names
                QStringList listInFileNames = RegexUtil::findAllAcuurances(file, "(?<={\\[).+?(?=]})");
                patternInFileNames->insert(file, listInFileNames);
                vars.append(listInFileNames);
            }

        } else {
            // Inside-files
            QFile f(file);
            f.open(QIODevice::ReadOnly);
            QStringList list = RegexUtil::findAllAcuurances(QString::fromStdString(f.readAll().toStdString()), "(?<={\\[).+?(?=]})");

            if (!list.isEmpty()) {
                patternInsideFiles->insert(f.fileName(), list);
                vars.append(list);
            }

            int i = 0;
            for (QString var : vars) {
                vars.replace(i, var.toUpper());
                i++;
            }
        }
    }

    vars.removeDuplicates();
    emit varsReady(vars);
}

void AddProject::generateProject(QVariant templateName, QVariant projectName, QVariant projectPath, QVariantMap vars)
{
    QString templatePath = QtUtil::getValue(ORGANIZATION, APPLICATION, TEMPLATES_GROUP, templateName.toString()).toString();
    QString qTemplatePath = QString::fromUtf8(templatePath.split("file://")[1].toStdString().c_str()) + "/templates/app";
    QString qProjectPath = projectPath.toString().split("file://")[1];

    QStringList files = FileUtil::getAllFilesInDir(qTemplatePath, QDir::Hidden | QDir::Files | QDir::Dirs);

    QDir qDir;
    qDir.cd(qProjectPath);
    qDir.mkdir(projectName.toString());

    for (QString file : files) {
        QString fullPath = file.split("/templates/app/")[1];
        QStringList listOfDirs = RegexUtil::findAllAcuurances(fullPath, ".*\\/");
        QString targetFile = fullPath.split("/").last();

        if (!listOfDirs.isEmpty()) {
            QDir qDir;
            QStringList subDirs = listOfDirs[0].split("/");
            QString rootDir = qProjectPath + "/" + projectName.toString() + "/";

            if (subDirs.length() > 1) {
                subDirs.removeLast();
                qDir.cd(rootDir);
                for (QString sd : subDirs) {
                    rootDir += sd + "/";
                    qDir.mkdir(sd);
                    qDir.cd(rootDir);
                }
                QFile::copy(file, rootDir + targetFile);
            } else {
                qDir.cd(rootDir);
                qDir.mkdir(subDirs[0]);
            }

        } else {
            QString targetItem = qProjectPath + "/" + projectName.toString() + "/" + QString::fromStdString(fullPath.toStdString());
            QFile::copy(file, targetItem);
        }
    }

    QString newProjectDirectory = qProjectPath + "/" + projectName.toString() + "/";
    QStringList newFiles = FileUtil::getAllFilesInDir(newProjectDirectory, QDir::Hidden | QDir::Files);

    for (QString file : newFiles) {
        if (file.contains("{[")) {
            QFile f(file);
            f.open(QIODevice::ReadOnly);
            QStringList list = RegexUtil::findAllAcuurances(QString::fromStdString(f.readAll().toStdString()), "(?<={\\[).+?(?=]})");
            f.close();

            if (!list.isEmpty()) {
                // Inside-file-names & Inside-files
                for (int i = 0; i < patternBothInsideFiles->keys().count(); i++) {
                    QStringList lVars = patternBothInsideFiles->values()[i];
                    for (int j = 0; j < lVars.count(); j++) {
                        QVariantMap::iterator h;
                        for (h = vars.begin(); h != vars.end(); ++h) {
                            if (&h.key() == lVars[j].toUpper()) {
                                QString rxString = QString("{[%1]}").arg(lVars[j]);
                                FileUtil::replaceString(file, rxString, h.value().toString());
                            }
                        }
                    }
                }

                for (int i = 0; i < patternBothInFileNames->keys().count(); i++) {
                    QStringList lVars = patternBothInFileNames->values()[i];
                    for (int j = 0; j < lVars.count(); j++) {
                        QVariantMap::iterator h;
                        for (h = vars.begin(); h != vars.end(); ++h) {
                            if (&h.key() == lVars[j].toUpper()) {
                                QString rxString = QString("{[%1]}").arg(lVars[j]);
                                QString oldPath = newProjectDirectory + patternBothInFileNames->keys()[i].split("templates/app/")[1];
                                QString newPath = oldPath;
                                newPath.replace("{[" + lVars[j] + "]}", h.value().toString());
                                QFile::rename(oldPath, newPath);
                            }
                        }
                    }
                }

            } else {
                // Inside-file-names
                for (int i = 0; i < patternInFileNames->keys().count(); i++) {
                    QStringList lVars = patternInFileNames->values()[i];
                    for (int j = 0; j < lVars.count(); j++) {
                        QVariantMap::iterator h;
                        for (h = vars.begin(); h != vars.end(); ++h) {
                            if (&h.key() == lVars[j].toUpper()) {
                                QString rxString = QString("{[%1]}").arg(lVars[j]);
                                QString oldPath = newProjectDirectory + patternInFileNames->keys()[i].split("templates/app/")[1];
                                QString newPath = oldPath;
                                newPath.replace("{[" + lVars[j] + "]}", h.value().toString());
                                QFile::rename(oldPath, newPath);
                            }
                        }
                    }
                }
            }

        } else {
            // Inside-files
            for (int i = 0; i < patternInsideFiles->keys().count(); i++) {
                QStringList lVars = patternInsideFiles->values()[i];
                for (int j = 0; j < lVars.count(); j++) {
                    QVariantMap::iterator h;
                    for (h = vars.begin(); h != vars.end(); ++h) {
                        if (&h.key() == lVars[j].toUpper()) {
                            QString rxString = QString("{[%1]}").arg(lVars[j]);
                            FileUtil::replaceString(file, rxString, h.value().toString());
                        }
                    }
                }
            }
        }
    }

    QtUtil::setKeyValue(ORGANIZATION, PROJECTS, templateName.toString(), projectName.toString(), newProjectDirectory);
    emit projectGenerated();
}
