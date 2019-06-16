#include "FileUtil.h"

#include <QDebug>
#include <dirent.h>
#include <iostream>
//#include <filesystem>

using namespace std;

FileUtil::FileUtil()
{
}

QString FileUtil::readStringFromFile(const QString& path, const QIODevice::OpenMode& mode)
{
    QSharedPointer<QFile> file(new QFile(path));
    QString data;
    if (file->open(mode)) {
        data = file->readAll();
        file->close();
    }
    return data;
}

QStringList FileUtil::readListFromFile(const QString& path, const QIODevice::OpenMode& mode)
{
    QStringList list = FileUtil::readStringFromFile(path, mode).trimmed().split("\n");
    return list;
}

std::string FileUtil::upperCaseAllChars(std::string word)
{
    for (int i = 0; i <= word.length(); i++) {
        if (word[i] >= 97 && word[i] <= 122) {
            word[i] = word[i] - 32;
        }
    }
    return word;
}

std::string FileUtil::lowerCaseAllChars(std::string word)
{
    for (int i = 0; i <= word.length(); i++) {
        if (word[i] >= 65 && word[i] <= 90) {
            word[i] = word[i] + 32;
        }
    }
    return word;
}

std::string FileUtil::capitilizeFirstChar(std::string word)
{
    bool cap = true;
    for (int i = 0; i <= word.length(); i++) {
        if (i == 0 && word[i] <= 122 && word[i] >= 97) {
            word[i] = word[i] - 32;
            cap = false;
        }
        //        if (cap ) {

        //        }
        else if (i != 0 && word[i] >= 65 && word[i] <= 90) {
            word[i] = word[i] + 32;
        }
    }
    return word;

    //    for (unsigned int i = 0; i <= word.length(); i++) {
    //        if (cap) {
    //            word[i] = toupper(word.toStdString()[i]);
    //            cap = false;
    //        } else {
    //            word[i] = tolower(word.toStdString()[i]);
    //        }
    //    }
    //    return word;
}

void FileUtil::replaceString(QString path, QString sourceText, QString targetText)
{
    QByteArray fileData;
    QFile file(path);
    file.open(QIODevice::ReadOnly); // open for read and write
    fileData = file.readAll(); // read all the data into the byte array
    QString text(fileData); // add to text string for easy string replace

    text.replace(QString(sourceText), QString(targetText)); // replace text in string

    file.close();

    if (file.open(QFile::WriteOnly | QFile::Truncate)) {
        QTextStream out(&file);
        out << text;
    }
    file.close();
}

void FileUtil::replaceString(QString path, QRegExp sourceText, QString targetText)
{
    QByteArray fileData;
    QFile file(path);
    file.open(QIODevice::ReadOnly); // open for read and write
    fileData = file.readAll(); // read all the data into the byte array
    QString text(fileData); // add to text string for easy string replace

    text.replace(sourceText, QString(targetText)); // replace text in string

    file.close();

    if (file.open(QFile::WriteOnly | QFile::Truncate)) {
        QTextStream out(&file);
        out << text;
    }
    file.close();
}

void FileUtil::renameFile(QString oldName, QString newName)
{
    QFile file(oldName);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    file.rename(newName);
    file.close();
}

QString FileUtil::determineWordType(QString word)
{
    char c;
    int i = 0;
    std::string str = "";
    QString output = "";

    int ccCount = 0;
    int lowerCount = 0;
    int upperCount = 0;
    int totalCount = word.size();

    bool isUpper = false;
    bool isLower = false;
    bool isCamelCase = false;
    str = word.toStdString().c_str();

    if (isupper(str[0])) {
        ccCount++;
        upperCount++;
        i++;
    } else {
        lowerCount++;
        i++;
    }

    while (str[i]) {
        c = str[i];
        if (isupper(c)) {
            upperCount++;
        } else if (islower(c)) {
            ccCount++;
            lowerCount++;
        }
        i++;
    }
    if (totalCount == ccCount) {
        isCamelCase = true;
        output = "isCamelCase";
    } else if (totalCount == lowerCount) {
        isLower = true;
        output = "isLower";
    } else if (totalCount == upperCount) {
        isUpper = true;
        output = "isUpper";
    } else {
        output = "Undefined";
    }
    return output;
}

bool FileUtil::writeFile(const QString& path, const QString& content, const QIODevice::OpenMode& mode)
{
    QFile file(path);

    if (file.open(mode)) {
        QTextStream stream(&file);
        stream << content.toUtf8() << endl;

        file.close();

        return true;
    }

    return false;
}

QStringList FileUtil::directoryList(const QString& path)
{
    QDir dir(path);
    QStringList list;
    for (const QFileInfo& info : dir.entryInfoList(QDir::NoDotAndDotDot | QDir::Dirs))
        list << info.fileName();
    return list;
}

quint64 FileUtil::getFileSize(const QString& path)
{
    quint64 totalSize = 0;
    QFileInfo info(path);
    if (info.exists()) {
        if (info.isFile()) {
            totalSize += info.size();
        } else if (info.isDir()) {
            QDir dir(path);
            for (const QFileInfo& i : dir.entryInfoList(QDir::NoDotAndDotDot | QDir::Files | QDir::Dirs)) {
                totalSize += getFileSize(i.absoluteFilePath());
            }
        }
    }
    return totalSize;
}

bool FileUtil::checkExistDirectory(QString dir)
{
    return QDir(dir).exists();
}

bool FileUtil::makeDirectory(QString dir)
{
    return QDir().mkdir(dir);
}

template <typename T>
vector<T> test(T begin, T end)
{
    size_t size = 0;

    for (auto it = begin; (it != end); it++) {
        size += it->size();
    }

    vector<T> ret = vector<T>(size);
    return ret;
}

void FileUtil::listFilesRecursively(const std::string& path, std::function<void(const std::string&)> cb)
{
    // Usage:
    //    FileUtil::listFiles(qTemplatePath.toStdString() + "/", [](const std::string& path) {
    //        std::cout << path << std::endl;
    //    });

    if (auto dir = opendir(path.c_str())) {
        while (auto f = readdir(dir)) {
            if (!f->d_name || f->d_name[0] == '.')
                continue;
            if (f->d_type == DT_DIR)
                listFilesRecursively(path + f->d_name + "/", cb);

            if (f->d_type == DT_REG)
                cb(path + f->d_name);
        }
        closedir(dir);
    }
}

QStringList FileUtil::getAllFilesInDir(QString dirPath, QDir::Filters filters, QStringList exceptions)
{
    QStringList files;

    QDirIterator it(dirPath, filters, QDirIterator::Subdirectories);
    if (exceptions.isEmpty()) {
        while (it.hasNext()) {
            auto currentItem = it.next();
            files.push_back(currentItem);
        }
    } else {
        while (it.hasNext()) {
            auto currentItem = it.next();
            files.push_back(currentItem);
            for (int i = 0; i < exceptions.length(); i++) {
                if (currentItem.endsWith(exceptions[i])) {
                    files.pop_back();
                }
            }
        }
    }
    return files;
}

bool FileUtil::fileExists(QString path)
{
    QFileInfo check_file(path);
    // check if file exists and if yes: Is it really a file and no directory?
    if (check_file.exists() && check_file.isFile()) {
        return true;
    } else {
        return false;
    }
}

bool FileUtil::dirExists(QString path)
{
    QFileInfo check_file(path);
    // check if file exists and if yes: Is it really a file and no directory?
    if (check_file.exists() && check_file.isDir()) {
        return true;
    } else {
        return false;
    }
}

bool FileUtil::copyRecursively(const QString& srcFilePath, const QString& tgtFilePath)
{
    QFileInfo srcFileInfo(srcFilePath);
    if (srcFileInfo.isDir()) {
        QDir targetDir(tgtFilePath);
        targetDir.cdUp();
        if (!targetDir.mkdir(QFileInfo(tgtFilePath).fileName()))
            return false;
        QDir sourceDir(srcFilePath);
        QStringList fileNames = sourceDir.entryList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot | QDir::Hidden | QDir::System);
        foreach (const QString& fileName, fileNames) {
            const QString newSrcFilePath
                = srcFilePath + QLatin1Char('/') + fileName;
            const QString newTgtFilePath
                = tgtFilePath + QLatin1Char('/') + fileName;
            if (!copyRecursively(newSrcFilePath, newTgtFilePath))
                return false;
        }
    } else {
        if (!QFile::copy(srcFilePath, tgtFilePath))
            return false;
    }
    return true;
}

//    QString filename = "Data.txt";
//    QFile file(filename);
//    if (file.open(QIODevice::ReadWrite)) {
//        QTextStream stream(&file);
//        stream << "something" << endl;
//    }

//    for (auto itEntry = fs::recursive_directory_iterator(dirPath.toStdString());
//         itEntry != fs::recursive_directory_iterator();
//         ++itEntry) {
//        const auto filenameStr = iterEntry->path().filename().string();
//        std::cout << std::setw(iterEntry.depth() * 3) << "";
//        std::cout << "dir:  " << filenameStr << '\n';
//    }

//    QDir currentDir(dirPath);
//    currentDir.setFilter(QDir::Dirs);
//    QStringList entries = currentDir.entryList();
//    for (QString ent : entries) {
//        qDebug() << ent;
//    }

//    using std::experimental::filesystem::recursive_directory_iterator;
//    for (auto& dirEntry : fs::recursive_directory_iterator(dirPath.toStdString()))
//        cout << dirEntry << endl;

//        if(it.next().endsWith(".ttf")||it.next().endsWith("otf"))
//        qDebug() << it.next();
//        QFile f(it.next());
//        f.open(QIODevice::ReadOnly);
//        qDebug() << f.fileName() << f.readAll().trimmed().toDouble() / 1000 << "MHz";

//    // Create a vector of string
//    std::vector<std::string> listOfFiles;
//    try {
//        // Check if given path exists and points to a directory
//        if (filesys::exists(dirPath) && filesys::is_directory(dirPath)) {
//            // Create a Recursive Directory Iterator object and points to the starting of directory
//            filesys::recursive_directory_iterator iter(dirPath);

//            // Create a Recursive Directory Iterator object pointing to end.
//            filesys::recursive_directory_iterator end;

//            // Iterate till end
//            while (iter != end) {
//                // Check if current entry is a directory and if exists in skip list
//                if (filesys::is_directory(iter->path()) && (std::find(dirSkipList.begin(), dirSkipList.end(), iter->path().filename()) != dirSkipList.end())) {
//                    // Skip the iteration of current directory pointed by iterator
//                    // c++17 Filesystem API to skip current directory iteration
//                    iter.disable_recursion_pending();
//                } else {
//                    // Add the name in vector
//                    listOfFiles.push_back(iter->path().string());
//                }

//                error_code ec;
//                // Increment the iterator to point to next entry in recursive iteration
//                iter.increment(ec);
//                if (ec) {
//                    std::cerr << "Error While Accessing : " << iter->path().string() << " :: " << ec.message() << '\n';
//                }
//            }
//        }
//    } catch (std::system_error& e) {
//        std::cerr << "Exception :: " << e.what();
//    }
//    return listOfFiles;
