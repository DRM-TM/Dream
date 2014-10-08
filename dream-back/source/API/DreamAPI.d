import	std.stdio;
import  std.conv;

import  mysql;
import	mysql.connection;
import  vibe.web.common;
import  vibe.d;

import  IDreamAPI;

import  Dream;
import  User;

class DreamAPI : IDreamAPI
{
    private string      _connStr;
    private Connection  _dbCon;

    this(string connStr)
    {
        _connStr = connStr;
        _dbCon = new Connection(_connStr);
        scope(exit) _dbCon.close();
        writefln("You have connected to server version %s", _dbCon.serverVersion);
        writefln("With currents stats : %s", _dbCon.serverStats());
        try _dbCon.selectDB("dream");
        catch (Exception e) {
            writefln("Exception caught: %s", e.toString());
        }
    }

    /**
     * Bullshit stuff for debug purpose ONLY
     */
    User*    getBullshitUsers() {
        return (null);
    }

    Dream*   getBullshitDreams() {
        return (null);
    }

    /**
     * User resource methods
     */

    // GET /user
    User[]  getUser() {
        ResultSet       result;
        Command         c;
        DBValue[string] aa;

        c = Command(_dbCon, "select * from user");
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLResult();
        catch (Exception e) {
            writefln("Exception caught in getDream: %s", e.toString());
        }
        if (result.empty())
            return (null);
        writeln("Results: ", result.length());
        Dream[]   users = new Dream[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            users[i] = new Dream(result.asAA());
            result.popFront();
        }
        return (users);
    }

    // GET /user/:uid
    User                getUser(uint _uid) {
        ResultSequence  result;
        Command         c;
        DBValue[string] aa;

        c = Command(_dbCon, "select * from user where id=" ~ to!string(_uid));
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLSequence();
        catch (Exception e) {
            writefln("Exception caught in getUser: %s", e.toString());
        }
        if (result.empty())
            return (new User());
        aa = result.asAA();
        return (new User(aa));
    }

    // GET /api/dream/:category
    Dream*  getDream(string category) {
        return (null);
    }

    // POST /user
    void    postUser(string email, string password) {
    }

    // DELETE /user/:id
    User    deleteUser(uint id) {
        return (null);
    }

    /**
     * Dream resource
     */

    // GET /dream
    Dream[] getDream() {
        ResultSet result;
        Command         c;
        DBValue[string] aa;

        c = Command(_dbCon, "select * from dream");
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLResult();
        catch (Exception e) {
            writefln("Exception caught in getDream: %s", e.toString());
        }
        if (result.empty())
            return (null);
        writeln("Results: ", result.length());
        Dream[]   dreams = new Dream[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            dreams[i] = new Dream(result.asAA());
            result.popFront();
        }
        return (dreams);
    }

    // GET /dream/:id
    Dream   getDream(uint _uid) {
        ResultSequence  result;
        Command         c;
        DBValue[string] aa;

        c = Command(_dbCon, "select * from dream where id=" ~ to!string(_uid));
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLSequence();
        catch (Exception e) {
            writefln("Exception caught in getDream(id): %s", e.toString());
        }
        if (result.empty())
            return (new Dream());
        aa = result.asAA();
        return (new Dream(aa));
    }

    // POST /dream
    void    postDream() {
    }

    // DELETE /dream/:id
    Dream    deleteDream(uint id) {
        return (null);
    }
}
