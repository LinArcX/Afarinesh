#include <QDebug>
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
#include "util/cpp/YamlUtil.h"
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

            // Inside-file-names & Inside-files
            if (!list.isEmpty()) {
                QStringList listInFileNames = RegexUtil::findAllAcuurances(file, "(?<={\\[).+?(?=]})");
                patternBothInFileNames->insert(file, listInFileNames);
                patternBothInsideFiles->insert(file, list);
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

            // Inside-file-names & Inside-files
            if (!list.isEmpty()) {
                for (int i = 0; i < patternBothInsideFiles->values().count(); i++) {
                    QString value;
                    QString var = patternBothInsideFiles->value(file)[i];
                    QString rxString = QString("(?<={\\[)%1(?=]})").arg(var);

                    QVariantMap::iterator j;
                    for (j = vars.begin(); j != vars.end(); ++j)
                        if (&j.key() == var.toUpper()) {
                            value = j.value().toString();
                        }

                    QRegExp rx(rxString);
                    QFile f(file);
                    f.open(QIODevice::ReadOnly);
                    QString::fromStdString(f.readAll().toStdString()).replace(rx, value);
                }

            } else {
            }

        } else {
        }
    }
}

//void AddProject::returnAppVars()
//{
//    QString outPut = QString(pListAppVars->readAllStandardOutput());
//    //    qDebug() << outPut;
//}

//                QStringList listInFileNames = RegexUtil::findAllAcuurances(file, "(?<={\\[).+?(?=]})");
//                patternBothInFileNames->insert(file, listInFileNames);
//                patternBothInsideFiles->insert(file, list);

//                // Inside-file-names
//                QStringList listInFileNames = RegexUtil::findAllAcuurances(file, "(?<={\\[).+?(?=]})");
//                patternInFileNames->insert(file, listInFileNames);

//            // Inside-files
//            QFile f(file);
//            f.open(QIODevice::ReadOnly);
//            QStringList list = RegexUtil::findAllAcuurances(QString::fromStdString(f.readAll().toStdString()), "(?<={\\[).+?(?=]})");

//            if (!list.isEmpty()) {
//                patternInsideFiles->insert(f.fileName(), list);
//            }

//    for (QString file : patternBothInsideFiles->keys()) {

//        for (int i = 0; i < patternBothInFileNames->values().count(); i++) {
//            QString value;
//            QString var = patternBothInFileNames->value(file)[i];
//            QString rxString = QString("(?<={\\[)%1(?=]})").arg(var);

//            QVariantMap::iterator j;
//            for (j = vars.begin(); j != vars.end(); ++j)
//                if (&j.key() == var.toUpper()) {
//                    value = j.value().toString();
//                }

//            QRegExp rx(rxString);
//            QFile f(file);
//            f.open(QIODevice::ReadOnly);
//            QString::fromStdString(f.readAll().toStdString()).replace(rx, value);
//        }

//        //        files.removeAll(file);
//    }

//    for (QString file : patternInsideFiles->keys()) {
//        files.removeAll(file);
//    }

//    for (QString file : patternInFileNames->keys()) {
//        files.removeAll(file);
//    }
//                cout << &j.key() << ": " << &j.value() << endl;
//            auto a = vars.find("d");

//        for (QString key : fileAdresses->keys()) {
//            if (key == file) {
//                qDebug() << file;
//                return;
//            } else {
//        break;
//            }
//        }

//    qDebug() << "----------------";
//    qDebug() << files.length();
//    qDebug() << "----------------";

//                if (item.contains("/")) {
//                    QString innerDir = item.split("/")[0];
//                    QDir qDir;
//                    qDir.cd(qProjectPath + "/" + projectName.toString() + "/");
//                    if (!qDir.exists(innerDir)) {
//                        qDir.mkdir(innerDir);
//                    }
//                }

//                QRegExp rx("");
//                QStringList list;
//                int pos = 0;

//                while ((pos = rx.indexIn(item, pos)) != -1) {
//                    list << rx.cap(1);
//                    pos += rx.matchedLength();
//                }
//                QString str = "Offsets: 12 14 99 231 7";
// list: ["12", "14", "99", "231", "7"]
//                qDebug() << item;

// Full address of files --> find . | ag "/.*(?<=\{\{).+?(?=\}\})[^/]*$" | awk -F/ '{print $NF}'
// Full Address of vars --> ag "(?<=\{\{).+?(?=\}\})" --hidden
// List all vars --> ag "(?<=\{\{).+?(?=\}\})" --hidden | awk -F: '{print $NF}' | grep -oP '(?<=\{\{).+?(?=\}\})'

//QString srcFilePath("/home/linarcx/Documents/print.pdf");
//                    qDir.mkdir(ttp);
//    QFileInfo srcFileInfo(srcFilePath);
//    if (srcFileInfo.isDir()) {
//        QDir targetDir(tgtFilePath);
//        targetDir.cdUp();
//        if (!targetDir.mkdir(QFileInfo(tgtFilePath).fileName()))
//            return false;
//        QDir sourceDir(srcFilePath);
//        QStringList fileNames = sourceDir.entryList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot | QDir::Hidden | QDir::System);
//        foreach (const QString& fileName, fileNames) {
//            const QString newSrcFilePath
//                = srcFilePath + QLatin1Char('/') + fileName;
//            const QString newTgtFilePath
//                = tgtFilePath + QLatin1Char('/') + fileName;
//            if (!copyRecursively(newSrcFilePath, newTgtFilePath))
//                return false;
//        }
//    } else {
//        if (!QFile::copy(srcFilePath, tgtFilePath))
//            return false;
//    }

//    QFile::copy("/home/linarcx/Documents/print.pdf", "/home/linarcx/mymine/print.pdf");

//    QString arg = QString("%1 && %2").arg("cd " + qTemplatePath, "ag\ttest");
//    pListAppVars = new QProcess(this);
//    connect(pListAppVars, &QProcess::readyReadStandardOutput, this, &AddProject::returnAppVars);
//    pListAppVars->startDetached("/usr/bin/sh", QStringList() << "-c" << arg);

//    //    QString t = "test";
//    QString options = QString("%1").arg("test");

//    pListAppVars->startDetached("zsh -c \"ag test\"");
//    pListAppVars->start("sh", QStringList() << "-c" << arg << "-o" << options);
//    pListAppVars->start("/usr/bin/ag", QStringList() << "test");

//    QProcess pCDHome;
//    pCDHome.start("sh", QStringList() << "-c"
//                                      << "cd /home/linarcx");
//    pCDHome.waitForFinished(2000);

//    connect(&pListAppVars, &QProcess::readyReadStandardOutput, [&]() {
//        QString outPut = QString(pListAppVars.readAllStandardOutput());
//        qDebug() << outPut;
//        //        if (outPut.contains("by-id/usb*")) {
//        //            QList<QString> qv;
//        //            emit modelReady(qv);
//        //        } else {
//        //            QStringList list = outPut.split("\n");
//        //            list.removeLast();
//        //            std::regex word_regex = Utils::getPattern();
//        //            QList<QString> model = list.toVector().toList();
//        //            emit modelReady(model);
//        //        }
//    });

//                std::regex r("(?<={{).+?(?=}})");
//                QStringList items = Utils::performRegxOnString(r, f.readAll().toStdString());
//                qDebug() << "sd";
//                //                std::regex word_regex = Utils::getSearchPattern();
//                //                qDebug() << "sd";
//QRegularExpression::MatchType matchType = matchTypeComboBox->currentData().value<QRegularExpression::MatchType>();

//    if (!FileUtil::checkExistDirectory(path.toString())) {
//        FileUtil::makeDirectory(path.toString());
//    }

//    QString targetPath = QDir::currentPath() + "/QtCpp/feature/feature.cpp";
//    string rawTarget = FileUtil::readStringFromFile(targetPath).toUtf8().toStdString();
//    char* target = ConvertUtil::stringToCharPointer(rawTarget);

//    string strAlternative = "rawAlternative.toString().toStdString();";
//    const char* alternative = strAlternative.c_str();

//    const char* cPattern = "\\{\\*c\\*}";
//    target = RegexUtil::findReplaseRegx(cPattern, alternative, target, RegexUtil::Replacement::CAMELCASE);

//    const char* uPattern = "\\{\\*u\\*}";
//    target = RegexUtil::findReplaseRegx(uPattern, alternative, target, RegexUtil::Replacement::UPPERCASE);

//    const char* lPattern = "\\{\\*l\\*}";
//    target = RegexUtil::findReplaseRegx(lPattern, alternative, target, RegexUtil::Replacement::LOWERCASE);
//    cout << target;

//    FileUtil::writeFile(path.toString() + name.toString(), target);
//    delete[] target;

//    QStringList list = Utils::beautifyOutput(outPut);
//    std::regex word_regex = Utils::getPattern();
//    QVariantList parent = Utils::performRegx(word_regex, list);
//    emit modelReady(parent);

//        for (QString ex : exceptions) {
//            }
//        }
