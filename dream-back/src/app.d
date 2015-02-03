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
  setLogLevel(LogLevel.debug_);
  runTask({
      ConfigFile	file = new ConfigFile;
      auto				router = new URLRouter;
      auto				settings = new HTTPServerSettings;
			string			connStr = file.asConnectionString();
      string			slash;

      version (Windows) {
				slash = `\`;
      } version (linux) {
				slash = `/`;
      }
      router.any("*", &setAccessControlOrigin);
      try registerRestInterface(router, new DreamAPI(connStr));
      catch(Exception e) {
				writeln("Failed to register interface: ", e.toString());
      }
      settings.port = 15030;
      listenHTTP(settings, router);
    });
}

/*****
**  SSL Stuff to check

string			privateKeyPath, certificatePath;
settings.sslContext = createSSLContext(SSLContextKind.server, SSLVersion.any);
try {
	writeln("Key: [", privateKeyPath, "]");
	writeln("Certificate: [", certificatePath, "]");
	settings.sslContext.usePrivateKeyFile(privateKeyPath);
	settings.sslContext.useCertificateChainFile(certificatePath);
	settings.sslContext.peerValidationMode = SSLPeerValidationMode.none;
} catch (Exception e) {
	writeln("Failed to load SSL stuff:\n", e.toString());
}
privateKeyPath = `SSL` ~ slash ~ `main.key`;
certificatePath = `SSL` ~ slash ~ `main.crt`;
*/
