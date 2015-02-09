module		app;

import		std.stdio;
import  	std.container;

import		vibe.core.core;
import		vibe.core.log;
import		vibe.http.router;
import		vibe.http.server;
import		vibe.http.common;
import		vibe.web.rest;
import		vibe.stream.ssl;
import		vibe.data.json;
import		vibe.data.serialization;

import		api.desc;
import		api.impl;

import		db.config;

/*
** Global vars
*/

DreamAPI	myApi;

/*****************/

/*
** Global request routines
*/

void			setAccessControlOrigin(HTTPServerRequest req, HTTPServerResponse res)
{
	try {
		/*
		** Token verification routine
		**
		** if (req.method == HTTPMethod.POST && req.json != null) {
		**	if (!myApi.isAllowed(req.json["token"].get!string)) {
		**		throw new HTTPStatusException(403);
		**	}
		** }
		**
		*/
	} catch (JSONException e) {
		throw new HTTPStatusException(401);
	}
	res.headers["Access-Control-Allow-Origin"] = "*";
	res.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE";
}

void sendOptions(HTTPServerRequest req, HTTPServerResponse res)
{
	setAccessControlOrigin(req, res);
	res.writeBody("");
}

/*****************/

shared static	this()
{
  setLogLevel(LogLevel.debug_);
  runTask({
      ConfigFile	file			= new ConfigFile;
      auto				router		= new URLRouter;
      auto				settings	= new HTTPServerSettings;
			string			connStr		= file.asConnectionString();
      string			slash;

      version (Windows) {
				slash = `\`;
      } version (linux) {
				slash = `/`;
      }
			myApi = new DreamAPI(connStr);
      router.any("*", &setAccessControlOrigin);
			router.match(HTTPMethod.OPTIONS, "*", &sendOptions);
      try registerRestInterface(router, myApi);
      catch(Exception e) {
				writeln("Failed to register interface: ", e.toString());
      }
			settings.options = HTTPServerOption.parseJsonBody|HTTPServerOption.defaults;
      settings.port = 15030;
      listenHTTP(settings, router);
    });
}

/*
**  SSL Stuff to check
**
**	string			privateKeyPath, certificatePath;
**	settings.sslContext = createSSLContext(SSLContextKind.server, SSLVersion.any);
**	try {
**		writeln("Key: [", privateKeyPath, "]");
**		writeln("Certificate: [", certificatePath, "]");
**		settings.sslContext.usePrivateKeyFile(privateKeyPath);
**		settings.sslContext.useCertificateChainFile(certificatePath);
**		settings.sslContext.peerValidationMode = SSLPeerValidationMode.none;
**	} catch (Exception e) {
**		writeln("Failed to load SSL stuff:\n", e.toString());
**	}
**	privateKeyPath = `SSL` ~ slash ~ `main.key`;
**	certificatePath = `SSL` ~ slash ~ `main.crt`;
**
*/
