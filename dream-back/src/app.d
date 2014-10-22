module	app;

import	std.stdio;

import	vibe.core.core;
import	vibe.core.log;
import	vibe.http.router;
import	vibe.http.server;
import	vibe.web.rest;
import	vibe.stream.ssl;

import	api.desc;
import	api.impl;

import	db.config;

void	setAccessControlOrigin(HTTPServerRequest req, HTTPServerResponse res)
{
	res.headers["Access-Control-Allow-Origin"] = "*";
}

shared static	this()
{
	/*setLogLevel(LogLevel.debug_);*/
	runTask({
		ConfigFile	file = new ConfigFile();
		string		connStr = file.asConnectionString();
		auto		router = new URLRouter;
		auto		settings = new HTTPServerSettings;

		router.any("*", &setAccessControlOrigin);
		try registerRestInterface(router, new DreamAPI(connStr));
		catch(Exception e) {
			writeln("Failed: ", e.toString());
		}
		settings.port = 15030;
		/*settings.sslContext = createSSLContext(SSLContextKind.server, SSLVersion.any);*/
		/*try {
			settings.sslContext.usePrivateKeyFile(`SSL\host.key`);
			settings.sslContext.useCertificateChainFile(`SSL\host.crt`);
			settings.sslContext.peerValidationMode = SSLPeerValidationMode.none;
			writeln(to!string(settings.sslContext.peerValidationMode));
		} catch (Exception e) {
			writeln("Failed to load SSL stuff: ", e.toString());
		}*/
		listenHTTP(settings, router);
	});

}
