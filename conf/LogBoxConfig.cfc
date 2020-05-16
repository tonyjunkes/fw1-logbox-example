component accessors="true" {
    property SentryDSN;

    void function configure() {
        logBox = {
            appenders: {
                // Sentry logger
                sentry: {
                  class: "subsystems.sentry.models.SentryAppender",
                  levelMax: "WARN",
                  levelMin: "FATAL",
                  properties: {
                    sentryService: new sentry.models.SentryService({
                      async: true,
                      DSN: variables.SentryDSN
                    })
                  }
                },
                // RollingFileAppender outputs to the logs/MYTESTLOG.log file
                myTestLog: {
                    class: "logbox.system.logging.appenders.RollingFileAppender",
                    levelMax: "WARN",
                    levelMin: "FATAL",
                    properties: {
                        filePath: "./logs",
                        autoExpand: true,
                        fileMaxSize: 3000,
                        fileMaxArchives: 5
                    }
                }
            },
            root: { levelmax: "DEBUG", levelMin: "FATAL", appenders: "*" },
            categories: {
                sentryLogger: { levelMin: "FATAL", levelMax: "INFO", appenders: "sentry" },
                fileLogger: { levelMin: "FATAL", levelMax: "INFO", appenders: "myTestLog" }
            }
        };
    }
}
