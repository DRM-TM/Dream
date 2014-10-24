module  db.config;

import  std.string;
import  std.file;
import  std.stdio;

import  vibe.data.json;

enum    DatabaseInfos {
    user,
    pwd,
    host,
    port,
    db
}

class ConfigFile
{
    private {
        string          _fileName;
        string[string]  _content;
        Json            _jsonObj;
    }

    this(string name = "db.json") {
        if (exists(name)) {
            _fileName = name;
            readFile();
        } else {
            writeln("Could not find database configuration file. Loading defaults:");
            _content["user"] = "root";
            _content["pwd"] = "";
            _content["host"] = "localhost";
            _content["port"] = "3306";
            _content["db"] = "database";
            writeln(_content);
        }
    }

    bool    readFile() {
        try {
            _jsonObj = parseJsonString(readText(_fileName), _fileName);
            _content["user"] = _jsonObj["user"].get!string;
            _content["pwd"] = _jsonObj["pwd"].get!string;
            _content["host"] = _jsonObj["host"].get!string;
            _content["port"] = _jsonObj["port"].get!string;
            _content["db"] = _jsonObj["db"].get!string;
        } catch (Exception e) {
            writeln("Exception: ", e.toString());
        }
        return (true);
    }

    @property string[string] asAA() {
        return (_content);
    }

    @property string    fileName() {
        return (_fileName);
    }

    @property string    asConnectionString() {
        string          ret = "";
        int             i = 0;

        foreach (key ; _content.keys) {
            ret ~= key ~ "=" ~ _content[key];
            if (i < _content.length - 1)
                ret ~= ";";
            ++i;
        }
        return (ret);
    }
}
