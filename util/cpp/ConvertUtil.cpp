#include <QVariant>
#include <iostream>

#include "ConvertUtil.h"

ConvertUtil::ConvertUtil()
{
}

char* ConvertUtil::stringToCharPointer(std::string strVar)
{
    char* ch = new char[strVar.length()];
    strcpy(ch, strVar.c_str());
    return ch;

    //    std::vector<char> writable(strVar.begin(), strVar.end()); /* 11 = len of Hello Heap + 1 char for \0*/
    //    writable.push_back('\0');
    //    charVar = &*writable.begin();
}
