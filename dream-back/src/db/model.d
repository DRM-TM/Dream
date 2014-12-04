module  db.model;

import  mysql;
import  vibe.d;

import  std.stdio;
import  std.conv : to;
import  std.string;
import  std.variant;
import  std.regex : match;


class Model(T, U) {
    private {
        string          _modelName;
        string          _primaryKey;
        string          _attributes;

        bool            _autoInc = true;

        uint            _limit = 0;

        Connection      _dbCon;
        /*SList!string    _foreignKey;*/
    }

    this(Connection con, string primKey = "id") {
        auto	tmp =  to!string(typeid(T)).split(".");

        _modelName = tmp[tmp.length - 1];
        _primaryKey = "id";
        _dbCon = con;
        generateAttributes();
    }

    void    generateAttributes() {
        auto    members = [ __traits(allMembers, T) ];
        bool    i = false;

        _attributes = "(";
        foreach (string attr ; members) {
            if (attr.startsWith("m_")) {
                auto ret = match(attr, r"^m_([A-Za-z_]+)");
                if (ret.captures[1] != _primaryKey && _autoInc) {
                    if (i)
                        _attributes ~= ",";
                    _attributes ~=  ret.captures[1];
                    i = true;
                }
            }
        }
        _attributes ~= ")";
        writeln("Attributes generated: ", _attributes);
    }

    @property ref   string  primaryKey() {
        return (_primaryKey);
    }

    @property       string  modelName() {
        return (_modelName);
    }

    @property ref       uint    limit() {
      return (_limit);
    }

    T[] all() {
        ResultSet       result;
        Command         c;
        DBValue[string] aa;
        string          query;

        query = "SELECT * FROM " ~ _modelName.toLower();
        if (_limit > 0) {
          query = query ~ " LIMIT " ~ to!string(_limit);
        }
        c = Command(_dbCon, query);
        writeln("[QUERY] Query raw: ", query);
        try result = c.execSQLResult();
        catch (Exception e) {
            writeln("Exception caught", e.toString());
        }
        if (result.empty())
            return (null);
        T[]   arr = new T[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            arr[i] = new T(result.asAA());
            result.popFront();
        }
        return (arr);
    }

    T   find(U value) {
        ResultSequence  result;
        Command         c;
        DBValue[string] aa;
        string          query;

        query = "SELECT * FROM " ~ _modelName.toLower() ~ " WHERE " ~ _primaryKey ~ "=" ~ to!string(value);
        if (_limit > 0) {
          query = query ~ " LIMIT " ~ to!string(_limit);
        }
        c = Command(_dbCon, query);
        writeln("[QUERY] Query raw: ", query);
        try result = c.execSQLSequence();
        catch (Exception e) {
            writeln("Exception caught:", e.toString());
        }
        if (result.empty())
            return (new T());
        aa = result.asAA();
        result.close();
        return (new T(aa));
    }

    T[] findCustomKey(V)(string key, V value) {
        ResultSet       result;
        Command         c;
        DBValue[string] aa;
        string          query;

        query = "SELECT * FROM " ~ _modelName.toLower() ~ " WHERE " ~ key ~ "=" ~ to!string(value);
        if (_limit > 0) {
          query = query ~ " LIMIT " ~ to!string(_limit);
        }
        c = Command(_dbCon, query);
        writeln("[QUERY] Query raw: ", query);
        try result = c.execSQLResult();
        catch (Exception e) {
            writeln("Exception caught", e.toString());
        }
        if (result.empty())
            return (null);
        T[]   arr = new T[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            arr[i] = new T(result.asAA());
            result.popFront();
        }
        return (arr);
    }

    bool   add(T toAdd) {
        string          query;
        ResultSequence  result;
        Command         c;

        query = "INSERT INTO " ~ _modelName.toLower() ~ " " ~ _attributes ~ " VALUES " ~ toAdd.asValues;
        try c = Command(_dbCon, query);
        catch (Exception e) {
            writeln("Exception caught: ", e.toString());
        }
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLSequence();
        catch (Exception e) {
          result.close();
          return (false);
        }
        result.close();
        return (true);
    }

    bool    del(U val) {
        string          query;
        ResultSequence  result;
        Command         c;

        query = "DELETE FROM " ~
                _modelName.toLower() ~
                " WHERE " ~
                _primaryKey ~ "=" ~ to!string(val);
        try c = Command(_dbCon, query);
        catch (Exception e) {
            writeln("Exception caught: ", e.toString());
        }
        writeln("[QUERY] Query raw: ", c.sql);
        c.execSQLSequence();
        result.close();
        return (true);
    }
}
