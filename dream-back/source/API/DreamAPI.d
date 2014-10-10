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
        scope(failure) _dbCon.close();
        writefln("You have connected to server version %s", _dbCon.serverVersion);
        writefln("With currents stats : %s", _dbCon.serverStats());
        try _dbCon.selectDB("dream");
        catch (Exception e) {
            writefln("Exception caught: %s", e.toString());
        }
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
        User[]   users = new User[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            users[i] = new User(result.asAA());
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


    // POST /user
    void    postUser(string email, string password, string token, string birthdate) {
        ResultSequence  result;
        Command         c;

        try c = Command(_dbCon,
                        "INSERT INTO user (email, password, inscription_date, last_connection, user_token, birthdate)
                        VALUES
                        (" ~ email ~ ", " ~ password ~ ", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, " ~ token ~ ", " ~ birthdate ~ ")");
        catch (Exception e) {
            writefln("Exception caught in postDream(uint uid, uint category_id, string content): %s", e.toString());
        }
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLSequence();
        catch (Exception e) {
            writefln("Exception caught in postDream(uint uid, uint category_id, string content): %s", e.toString());
        }
    }

    // DELETE /user
    void    deleteUser(uint id) {
        ResultSequence  result;
        Command         c;

        try c = Command(_dbCon,
                        "DELETE FROM user
                        WHERE
                        id=" ~ to!string(id));
        catch (Exception e) {
            writefln("Exception caught in void    deleteUser(uint id): %s", e.toString());
        }
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLSequence();
        catch (Exception e) {
            writefln("Exception caught in void    deleteUser(uint id): %s", e.toString());
        }
    }

    /**
     * Dream resource
     */

    // GET /api/dream/incategory/:uid
    Dream[]  getDreamIncategory(uint _uid) {
        ResultSet       result;
        Command         c;
        DBValue[string] aa;

        c = Command(_dbCon, "select * from dream where category_id=" ~ to!string(_uid));
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLResult();
        catch (Exception e) {
            writefln("Exception caught in getDreamIncategory(uid): %s", e.toString());
        }
        if (result.empty())
            return (null);
        Dream[]   dreams = new Dream[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            dreams[i] = new Dream(result.asAA());
            result.popFront();
        }
        return (dreams);
    }

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
        Dream[]   dreams = new Dream[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            dreams[i] = new Dream(result.asAA());
            result.popFront();
        }
        return (dreams);
    }

    // GET /api/dream/:uid
    Dream   getDream(uint _uid) {
        ResultSequence  result;
        Command         c;
        DBValue[string] aa;

        try c = Command(_dbCon, "select * from dream where id=" ~ to!string(_uid));
        catch (Exception e) {
            writefln("Exception caught in getDream(id): %s", e.toString());
        }
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
    void                postDream(uint uid, uint category_id, string content) {
        ResultSequence  result;
        Command         c;

        try c = Command(_dbCon,
                        "INSERT INTO dream (user_id, category_id, content, date)
                        VALUES
                        (" ~ to!string(uid) ~ ", " ~ to!string(category_id) ~ ", \"" ~ to!string(content) ~ "\", CURRENT_TIMESTAMP)");
        catch (Exception e) {
            writefln("Exception caught in postDream(uint uid, uint category_id, string content): %s", e.toString());
        }
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLSequence();
        catch (Exception e) {
            writefln("Exception caught in postDream(uint uid, uint category_id, string content): %s", e.toString());
        }
    }

    // DELETE /dream
    void    deleteDream(uint uid) {
        ResultSequence  result;
        Command         c;

        try c = Command(_dbCon,
                        "DELETE FROM dream
                        WHERE
                        id=" ~ to!string(id));
        catch (Exception e) {
            writefln("Exception caught in void    deleteUser(uint id): %s", e.toString());
        }
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLSequence();
        catch (Exception e) {
            writefln("Exception caught in void    deleteUser(uint id): %s", e.toString());
        }
    }
}
