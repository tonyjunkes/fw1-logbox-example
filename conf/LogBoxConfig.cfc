component {
    void function configure() {
        logBox = {
            appenders = {
                // RollingFileAppender outputs to the logs/MYTESTLOG.log file
                myTestLog = {
                    class = "logbox.system.logging.appenders.RollingFileAppender",
                    levelMax = "WARN",
                    levelMin = "FATAL",
                    properties = {
                        filePath = "./logs",
                        autoExpand = true,
                        fileMaxSize = 3000,
                        fileMaxArchives = 5
                    }
                }      
            },
            root = { levelmax = "DEBUG", levelMin = "FATAL", appenders = "*" }
        };
    }
}
