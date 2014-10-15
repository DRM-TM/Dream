import	std.stdio;
import  std.conv;

import  mysql;
import	mysql.connection;
import  vibe.web.common;
import  vibe.d;

import  IDreamAPI;

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
        try _dbCon.SELECTDB("dream");
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

        c = Command(_dbCon, "SELECT * FROM user");
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

        c = Command(_dbCon, "SELECT * FROM user WHERE id=" ~ to!string(_uid));
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

    Fdream  solveDream(Dream base) {
        Fdream      ret = new Fdream();
        Dream       content = base;
        User        user = getUser(to!uint(base.user_id));
        Comment[]   comments = getCommentByDreamId(to!uint(base.id));
        Hashtag[]   hashtags = getHashtagByDreamId(to!uint(base.id));

        ret.content = content;
        ret.user = user;
        ret.comments = comments;
        ret.hashtags = hashtags;
        return (ret);
    }

    // GET /api/dream/incategory/:cat_id
    Dream[]  getDreamIncategory(uint _cat_id) {
        ResultSet       result;
        Command         c;
        DBValue[string] aa;

        c = Command(_dbCon, "SELECT * FROM dream WHERE category_id=" ~ to!string(_cat_id));
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
    Fdream[] getDream() {
        ResultSet result;
        Command         c;
        DBValue[string] aa;

        c = Command(_dbCon, "SELECT * FROM dream");
        writeln("[QUERY] Query raw: ", c.sql);
        try result = c.execSQLResult();
        catch (Exception e) {
            writefln("Exception caught in getDream: %s", e.toString());
        }
        if (result.empty())
            return (null);
        Fdream[]   dreams = new Fdream[to!uint(result.length())];
        for (auto i = 0 ; !result.empty() ; ++i) {
            dreams[i] = solveDream(new Dream(result.asAA()));
            result.popFront();
        }
        return (dreams);
    }

    // GET /api/dream/:uid
    Dream   getDream(uint _uid) {
        ResultSequence  result;
        Command         c;
        DBValue[string] aa;

        try c = Command(_dbCon, "SELECT * FROM dream WHERE id=" ~ to!string(_uid));
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
                        id=" ~ to!string(uid));
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
     * Comment resource
     */

     // GET /api/comment
     Comment[]  getComment() {
         ResultSet          result;
         Command            c;
         DBValue[string]    aa;

         c = Command(_dbCon, "SELECT * FROM comment");
         writeln("[QUERY] Query raw: ", c.sql);
         try result = c.execSQLResult();
         catch (Exception e) {
             writefln("Exception caught in getDream: %s", e.toString());
         }
         if (result.empty())
             return (null);
         Comment[]   comments = new Comment[to!uint(result.length())];
         for (auto i = 0 ; !result.empty() ; ++i) {
             comments[i] = new Comment(result.asAA());
             result.popFront();
         }
         return (comments);
     }

     // GET /api/comment/:uid
     Comment    getComment(uint _uid) {
         ResultSequence  result;
         Command         c;
         DBValue[string] aa;

         try c = Command(_dbCon, "SELECT * FROM comment WHERE id=" ~ to!string(_uid));
         catch (Exception e) {
             writefln("Exception caught in getComment(id): %s", e.toString());
         }
         writeln("[QUERY] Query raw: ", c.sql);
         try result = c.execSQLSequence();
         catch (Exception e) {
             writefln("Exception caught in getComment(id): %s", e.toString());
         }
         if (result.empty())
             return (new Comment());
         aa = result.asAA();
         return (new Comment(aa));
     }

     // GET /api/comment/bydreamid/:dream_id
     Comment[]  getCommentByDreamId(uint _dream_id) {
         ResultSet         result;
         Command           c;
         DBValue[string]   aa;

         try c = Command(_dbCon, "SELECT * FROM comment WHERE dream_id=" ~ to!string(_dream_id));
         catch (Exception e) {
             writefln("Exception caught in getCommentByDreamId(_dream_id): %s", e.toString());
         }
         writeln("[QUERY] Query raw: ", c.sql);
         try result = c.execSQLResult();
         catch (Exception e) {
             writefln("Exception caught in getCommentByDreamId(_dream_id): %s", e.toString());
         }
         if (result.empty())
             return (null);
         Comment[]   comments = new Comment[to!uint(result.length())];
         for (auto i = 0 ; !result.empty() ; ++i) {
             comments[i] = new Comment(result.asAA());
             result.popFront();
         }
         return (comments);
     }

    // GET /api/comment/byuserid/:uid
     Comment[]  getCommentByUserId(uint _uid) { return (null); }

     // DELETE /api/comment
     void   deleteComment(uint uid) {
         ResultSequence  result;
         Command         c;

         try c = Command(_dbCon,
                         "DELETE FROM comment
                         WHERE
                         id=" ~ to!string(uid));
         catch (Exception e) {
             writefln("Exception caught in void    deleteComment(uint id): %s", e.toString());
         }
         writeln("[QUERY] Query raw: ", c.sql);
         try result = c.execSQLSequence();
         catch (Exception e) {
             writefln("Exception caught in void    deleteComment(uint id): %s", e.toString());
         }
     }

     // POST /api/comment
     void   postComment(uint uid, uint dream_id, string content) { }

     /**
      * Hashtag resource
      */

      // GET /api/hashtag
      Hashtag[]  getHashtag() {
          ResultSet          result;
          Command            c;
          DBValue[string]    aa;

          c = Command(_dbCon, "SELECT * FROM hashtag");
          writeln("[QUERY] Query raw: ", c.sql);
          try result = c.execSQLResult();
          catch (Exception e) {
              writefln("Exception caught in getDream: %s", e.toString());
          }
          if (result.empty())
              return (null);
          Hashtag[]   hashtags = new Hashtag[to!uint(result.length())];
          for (auto i = 0 ; !result.empty() ; ++i) {
              hashtags[i] = new Hashtag(result.asAA());
              result.popFront();
          }
          return (hashtags);
      }

      // GET /api/hashtag/:uid
      Hashtag    getHashtag(uint _uid) {
          ResultSequence    result;
          Command           c;
          DBValue[string]   aa;

          try c = Command(_dbCon, "SELECT * FROM hashtag WHERE id=" ~ to!string(_uid));
          catch (Exception e) {
              writefln("Exception caught in getHashtag(id): %s", e.toString());
          }
          writeln("[QUERY] Query raw: ", c.sql);
          try result = c.execSQLSequence();
          catch (Exception e) {
              writefln("Exception caught in getHashtag(id): %s", e.toString());
          }
          if (result.empty())
              return (new Hashtag());
          aa = result.asAA();
          return (new Hashtag(aa));
      }

      // GET /api/hashtag/bydreamid/:dream_id
      Hashtag[]  getHashtagByDreamId(uint _dream_id) {
          ResultSet         result;
          Command           c;
          DBValue[string]   aa;

          try c = Command(_dbCon, "SELECT * FROM hashtag WHERE dream_id=" ~ to!string(_dream_id));
          catch (Exception e) {
              writefln("Exception caught in getHashtagByDreamId(_dream_id): %s", e.toString());
          }
          writeln("[QUERY] Query raw: ", c.sql);
          try result = c.execSQLResult();
          catch (Exception e) {
              writefln("Exception caught in getHashtagByDreamId(_dream_id): %s", e.toString());
          }
          if (result.empty())
              return (null);
          Hashtag[]   hashtags = new Hashtag[to!uint(result.length())];
          for (auto i = 0 ; !result.empty() ; ++i) {
              hashtags[i] = new Hashtag(result.asAA());
              result.popFront();
          }
          return (hashtags);
      }

     // GET /api/hashtag/byuserid/:uid
      Hashtag[]  getHashtagByUserId(uint _uid) {
          ResultSet         result;
          Command           c;
          DBValue[string]   aa;

          try c = Command(_dbCon, "SELECT * FROM hashtag WHERE user_id=" ~ to!string(_uid));
          catch (Exception e) {
              writefln("Exception caught in getHashtagByDreamId(user_id): %s", e.toString());
          }
          writeln("[QUERY] Query raw: ", c.sql);
          try result = c.execSQLResult();
          catch (Exception e) {
              writefln("Exception caught in getHashtagByDreamId(user_id): %s", e.toString());
          }
          if (result.empty())
              return (null);
          Hashtag[]   hashtags = new Hashtag[to!uint(result.length())];
          for (auto i = 0 ; !result.empty() ; ++i) {
              hashtags[i] = new Hashtag(result.asAA());
              result.popFront();
          }
          return (hashtags);
      }

      // DELETE /api/hashtag
      void   deleteHashtag(uint uid) {
          ResultSequence  result;
          Command         c;

          try c = Command(_dbCon,
                          "DELETE FROM hashtag
                          WHERE
                          id=" ~ to!string(uid));
          catch (Exception e) {
              writefln("Exception caught in void    deleteHashtag(uint id): %s", e.toString());
          }
          writeln("[QUERY] Query raw: ", c.sql);
          try result = c.execSQLSequence();
          catch (Exception e) {
              writefln("Exception caught in void    deleteHashtag(uint id): %s", e.toString());
          }
      }

      // POST /api/hashtag
      void   postHashtag(uint uid, uint dream_id, string content) { }
}
