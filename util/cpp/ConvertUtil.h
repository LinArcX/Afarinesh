#ifndef CONVERTUTIL_H
#define CONVERTUTIL_H

#include <iostream>

class ConvertUtil {
private:
    ConvertUtil();

public:
    static char* stringToCharPointer(std::string strVar);
};

#endif // CONVERTUTIL_H
