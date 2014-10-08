import	vibe.core.core;
import	vibe.core.log;
import	vibe.http.router;
import	vibe.http.server;
import	vibe.web.rest;

import	std.stdio;

import	IDreamAPI;
import	DreamAPI;

shared static	this()
{
	setLogLevel(LogLevel.debug_);
	runTask({
		string		connStr = "host=localhost;port=3306;user=ganich;pwd=00df337a0c;db=dream";
		auto		router = new URLRouter;
		auto		settings = new HTTPServerSettings;

		try registerRestInterface(router, new DreamAPI(connStr));
		catch(Exception e) {
			writeln("Failed: ", e.toString());
		}
		settings.port = 15030;
		listenHTTP(settings, router);
	});
}
