component extends="framework.one"
	output=false
{
	this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
	this.mappings = {
		"/logbox" = expandPath("./subsystems/logbox"),
		"/sentry" = expandPath("./subsystems/sentry"),
		// Mapping alias for LogBox/Sentry.io support
		// If you'd like to avoid doing this, update SentryAppender.cfc
		// to extend logbox.system.logging.AbstractAppender
		"/coldbox" = expandPath("./subsystems/logbox")
	};

	// FW/1 settings
	variables.framework = {
		defaultSection: "main",
		defaultItem: "default",
		error: "main.error",
		diEngine: "di1",
		diLocations: ["/model"],
		diConfig: {
			loadListener: (di1) => {
				di1.declare("Logger").asValue(getBeanFactory("logbox").getBean("LogBox")).asTransient();
			}
		},
		subsystems: {
			logbox: {
				diLocations: ["/logbox"],
				diConfig: {
					loadListener: (di1) => {
						// Update SentryDSN for connecting to Sentry.io
						// URL format: https://########@########.ingest.sentry.io/########
						di1.declare("SentryDSN").asValue("");

						//*****************************************************************
						// NOTE: ACF chokes if we declare LogBox's config and core
						// in one chain so the builder is broken up into multiple declares
						//*****************************************************************

						// Create instance of our application config for LogBox to inject private settings
						di1.declare("LogBoxAppConfig").instanceOf("conf.LogBoxConfig");
						// Create instance of LogBox config using the application config settings
						di1.declare("LogBoxConfig").instanceOf("logbox.system.logging.config.LogBoxConfig")
							.withOverrides({ CFCConfig: di1.getBean("LogBoxAppConfig") }).asTransient();
						// Create instance of LogBox using our config instance
						di1.declare("LogBox").instanceOf("logbox.system.logging.LogBox")
							.withOverrides({ config: di1.getBean("LogBoxConfig") }).asTransient();
					}
				}
			}
		},
		trace: true,
		reloadApplicationOnEveryRequest: true
	};

	public string function onMissingView(struct rc) {
		return "Error 404 - Page not found.";
	}
}
