import	vibe.core.core;
import	vibe.core.log;
import	vibe.http.router;
import	vibe.http.server;
import	vibe.web.rest;
import	vibe.stream.ssl;

import	std.stdio;

import	IDreamAPI;
import	DreamAPI;

shared static	this()
{
	setLogLevel(LogLevel.debug_);
	runTask({
		string		connStr = "host=roemer.im;port=3306;user=dream;pwd=vizzerdrix;db=dream";
		auto		router = new URLRouter;
		auto		settings = new HTTPServerSettings;

		try registerRestInterface(router, new DreamAPI(connStr));
		catch(Exception e) {
			writeln("Failed: ", e.toString());
		}
		settings.port = 15030;
		/*settings.sslContext = createSSLContext(SSLContextKind.server, SSLVersion.any);
		try {
			settings.sslContext.usePrivateKeyFile("SSL\\host.key");
			settings.sslContext.useCertificateChainFile(`SSL\host.cert`);
			settings.sslContext.peerValidationMode = SSLPeerValidationMode.none;
			writeln(to!string(settings.sslContext.peerValidationMode));
		} catch (Exception e) {
			writeln("Failed to load SSL stuff: ", e.toString());
		}*/
		listenHTTP(settings, router);
	});
}
