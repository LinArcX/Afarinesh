#pragma once

// List of vars --> ag "(?<=\{\{).+?(?=\}\})" --hidden | awk -F: '{print $NF}' | grep -oP '(?<=\{\{).+?(?=\}\})'
//#define LIST_ALL_VARS "cd /home/linarcx/Documents/templates/QtCpp/templates/app; ag \"(?<=\\{\\{).+?(?=\\}\\})\" --hidden " //| awk -F: '{print $NF}' | grep -oP '(?<=\{\{).+?(?=\}\})'
#define LIST_ALL_VARS "cd /home/linarcx && ls" //| awk -F: '{print $NF}' | grep -oP '(?<=\{\{).+?(?=\}\})'
#define APP "app"
#define DISPATCHER "dispatcher"
#define MAIN_QML "qrc:/pages/launcher.qml"

#define ORGANIZATION "io.github.linarcx"
#define APPLICATION "trinity"
#define TEMPLATES_GROUP "Templates"
