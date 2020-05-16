# FW/1 & LogBox Example
An example of using LogBox as a Subsystem in an FW/1 application.

http://tonyjunkes.com/blog/using-logbox-for-logging-in-fw1/

### How to use:

- Make sure you have [CommandBox installed](https://commandbox.ortusbooks.com/content/setup/installation.html).
- Clone the repo or drop the zipped contents into a directory.
- Fire up CommandBox by entering `box` in your terminal and `cd` into the project root directory.
- Run `install && start`.
- Start hacking away!

### Version 0.3.0 Adds Support For Testing Sentry.io Logs

Update the SentryDSN bean declaration to use your project DSN URL for everything to connect.

> NOTE: In order to use Sentry.io in this example, you will need to create an account/project at https://sentry.io/
> At the time of writing these instructions, you will also need to update the `url` value in SentryService.cfc, line: 657 to be `getSentryUrl() & "/api/" & getProjectID() & "/store/"`.
