component extends="framework.one"
	output=false
{
	this.applicationTimeout = createTimeSpan(0, 2, 0, 0);
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
	this.mappings = {
		"/logbox" = expandPath("./subsystems/logbox")
	};

	// FW/1 settings
	variables.framework = {
		defaultSection: "main",
		defaultItem: "default",
		error: "main.error",
		diEngine: "di1",
		diLocations: ["/model"],
		diConfig: {
			loadListener: function(di1) {
				di1.declare("Logger").asValue(getBeanFactory("logbox").getBean("LogBox")).asTransient();
			}
		},
		subsystems: {
			logbox: {
				diLocations: ["/logbox"],
				diConfig: {
					loadListener: function(di1) {
						// ACF chokes if we declare LogBox's config and core in one chain
						// so the builder is broken up into two instances
						di1.declare("LogBoxConfig").instanceOf("logbox.system.logging.config.LogBoxConfig")
							.withOverrides({ CFCConfigPath: "conf.LogBoxConfig" }).asTransient();
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
