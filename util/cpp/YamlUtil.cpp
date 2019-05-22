#include <QVariant>
#include <iostream>
#include <yaml.h>

#include "YamlUtil.h"

YamlUtil::YamlUtil()
{
}

std::string YamlUtil::getValue(const std::string configFile, std::string prop)
{
    std::string value;
    FILE* fh = fopen(configFile.c_str(), "r");
    yaml_parser_t parser;
    //        yaml_token_t token; /* new variable */
    yaml_event_t event; /* New variable */

    /* Initialize parser */
    if (!yaml_parser_initialize(&parser))
        fputs("Failed to initialize parser!\n", stderr);
    if (fh == NULL)
        fputs("Failed to open file!\n", stderr);

    /* Set input file */
    yaml_parser_set_input_file(&parser, fh);

    /* START new code */
    do {
        static int state = 0;
        static bool canReadValue = false;
        if (!yaml_parser_parse(&parser, &event)) {
            printf("Parser error %d\n", parser.error);
            exit(EXIT_FAILURE);
        }
        switch (event.type) {
        case YAML_NO_EVENT:
            //puts("No event!");
            break;
        /* Stream start/end */
        case YAML_STREAM_START_EVENT:
            //puts("STREAM START");
            break;
        case YAML_STREAM_END_EVENT:
            //puts("STREAM END");
            break;
        /* Block delimeters */
        case YAML_DOCUMENT_START_EVENT:
            //puts("<b>Start Document</b>");
            break;
        case YAML_DOCUMENT_END_EVENT:
            //puts("<b>End Document</b>");
            break;
        case YAML_SEQUENCE_START_EVENT:
            //puts("<b>Start Sequence</b>");
            break;
        case YAML_SEQUENCE_END_EVENT:
            //puts("<b>End Sequence</b>");
            break;
        case YAML_MAPPING_START_EVENT:
            //puts("<b>Start Mapping</b>");
            break;
        case YAML_MAPPING_END_EVENT:
            //puts("<b>End Mapping</b>");
            break;
        /* Data */
        case YAML_ALIAS_EVENT:
            //printf("Got alias (anchor %s)\n", event.data.alias.anchor);
            break;
        case YAML_SCALAR_EVENT:
            //printf("Got scalar (value %s)\n", event.data.scalar.value);
            if (state == 0 && strncmp(reinterpret_cast<const char*>(event.data.scalar.value), prop.c_str(), 20) == 0) {
                canReadValue = true;
                state = 1;
            } else if (state == 1 && canReadValue) {
                value = reinterpret_cast<const char*>(event.data.scalar.value);
                canReadValue = false;
                state = 0;
            }
            break;
        }
        if (event.type != YAML_STREAM_END_EVENT)
            yaml_event_delete(&event);
    } while (event.type != YAML_STREAM_END_EVENT);
    yaml_event_delete(&event);
    /* END new code */

    /* Cleanup */
    yaml_parser_delete(&parser);
    fclose(fh);

    return value;

    //        /* BEGIN new code */
    //        do {
    //            yaml_parser_scan(&parser, &token);
    //            switch (token.type) {
    //            /* Stream start/end */
    //            case YAML_STREAM_START_TOKEN:
    //                puts("STREAM START");
    //                break;
    //            case YAML_STREAM_END_TOKEN:
    //                puts("STREAM END");
    //                break;
    //            /* Token types (read before actual token) */
    //            case YAML_KEY_TOKEN:
    //                printf("(Key token)   ");
    //                break;
    //            case YAML_VALUE_TOKEN:
    //                printf("(Value token) ");
    //                break;
    //            /* Block delimeters */
    //            case YAML_BLOCK_SEQUENCE_START_TOKEN:
    //                puts("Start Block (Sequence)");
    //                break;
    //            case YAML_BLOCK_ENTRY_TOKEN:
    //                puts("Start Block (Entry)");
    //                break;
    //            case YAML_BLOCK_END_TOKEN:
    //                puts("End block");
    //                break;
    //            /* Data */
    //            case YAML_BLOCK_MAPPING_START_TOKEN:
    //                puts("[Block mapping]");
    //                break;
    //            case YAML_SCALAR_TOKEN:
    //                printf("scalar %s \n", token.data.scalar.value);
    //                break;
    //            /* Others */
    //            default:
    //                printf("Got token of type %d\n", token.type);
    //            }
    //            if (token.type != YAML_STREAM_END_TOKEN)
    //                yaml_token_delete(&token);
    //        } while (token.type != YAML_STREAM_END_TOKEN);
    //        yaml_token_delete(&token);
    //        /* END new code */

    //        QSettings settings(COMPANY_NAME, APP_NAME);
    //        settings.beginGroup(APP_GROUP);
    //        QString osName = qvariant_cast<QString>(settings.value(OS));
    //        if (osName.isEmpty() == true) {
    //            QProcess pOS;
    //            pOS.start("sh", QStringList() << "-c" << OS_NAME);
    //            pOS.waitForFinished();
    //            std::string osName = std::string(pOS.readAllStandardOutput());
    //            osName.erase(std::remove(osName.begin(), osName.end(), '\n'), osName.end());
    //            settings.setValue(OS, QString::fromStdString(osName));
    //        }
    //        settings.endGroup();
}
