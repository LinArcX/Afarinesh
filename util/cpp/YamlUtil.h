#ifndef YAMLUTIL_H
#define YAMLUTIL_H

#include <iostream>

class YamlUtil {

public:
    static std::string getValue(const std::string configFile, std::string prop);

private:
    YamlUtil();
};

#endif // YAMLUTIL_H
