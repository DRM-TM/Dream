module  api.impl;

import	std.stdio;
import  std.conv;

import	mysql.connection;

import  vibe.d;

import  res.user;
import  res.comment;
import  res.hashtag;
import  res.dream;

import  col.fdream;

import  api.desc;
import 	db.model;

class   DreamAPI : IDreamAPI
{
    private {
        string                  _connStr;
        Connection              _dbCon;

        Model!(User, uint)      _userRes;
        Model!(Dream, uint)     _dreamRes;
        Model!(Comment, uint)   _commentRes;
        Model!(Hashtag, uint)   _hashtagRes;
    }

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
        _userRes = new Model!(User, uint)(_dbCon);
        _dreamRes = new Model!(Dream, uint)(_dbCon);
        _commentRes = new Model!(Comment, uint)(_dbCon);
        _hashtagRes = new Model!(Hashtag, uint)(_dbCon);
    }

    /**
     * User resource methods
     */

    // GET /user
    User[]  getUser() {
        return (_userRes.all());
    }

    // GET /user/:uid
    User                getUser(uint _uid) {
        return (_userRes.find(_uid));
    }


    // POST /user
    bool    postUser(string email, string password, string token, string birthdate, string username) {
        User toAdd = new User();

        toAdd.m_email = email;
        toAdd.m_password = password;
        toAdd.m_user_token = token;
        toAdd.m_birthdate = birthdate;
        toAdd.m_username = username;
        return (_userRes.add(toAdd));
    }

    // DELETE /user/:uid
    bool    deleteUser(uint _uid) {
        return (_userRes.del(_uid));
    }

    /**
     * Dream resource
     */

    Fdream  solveDream(Dream base) {
        Fdream      ret = new Fdream();
        Dream       content = base;
        User        user = getUser(to!uint(base.m_user_id));
        Comment[]   comments = getCommentByDreamId(to!uint(base.m_id));
        Hashtag[]   hashtags = getHashtagByDreamId(to!uint(base.m_id));

        ret.content = content;
        ret.user = user;
        ret.comments = comments;
        ret.hashtags = hashtags;
        return (ret);
    }

    // GET /api/dream/incategory/:cat_id
    Dream[]  getDreamIncategory(uint _cat_id) {
        return (_dreamRes.findCustomKey!uint("category_id", _cat_id));
    }

    // GET /dream
    Fdream[] getDream() {
        Dream[]     result = _dreamRes.all();
        Fdream[]    dreams = new Fdream[to!uint(result.length)];

        for (auto i = 0 ; i < result.length ; ++i) {
            dreams[i] = solveDream(result[i]);
        }
        return (dreams);
    }

    // GET /api/dream/:uid
    Dream   getDream(uint _uid) {
        return (_dreamRes.find(_uid));
    }

    // POST /dream
    bool                postDream(uint uid, uint category_id, string content) {
        Dream   toAdd = new Dream();

        toAdd.m_user_id = to!string(uid);
        toAdd.m_category_id = to!string(category_id);
        toAdd.m_content = content;
        return (_dreamRes.add(toAdd));
    }

    // DELETE /dream
    bool    deleteDream(uint _uid) {
        return (_dreamRes.del(_uid));
    }

    /**
     * Comment resource
     */

     // GET /api/comment
     Comment[]  getComment() {
         return (_commentRes.all());
     }

     // GET /api/comment/:uid
     Comment    getComment(uint _uid) {
         return (_commentRes.find(_uid));
     }

     // GET /api/comment/bydreamid/:dream_id
     Comment[]  getCommentByDreamId(uint _dream_id) {
         return (_commentRes.findCustomKey!uint("dream_id", _dream_id));
     }

    // GET /api/comment/byuserid/:uid
     Comment[]  getCommentByUserId(uint _uid) {
         return (_commentRes.findCustomKey!uint("user_id", _uid));
     }

     // DELETE /api/comment
     bool   deleteComment(uint _uid) {
         return (_commentRes.del(_uid));
     }

     // POST /api/comment
     bool   postComment(uint uid, uint dream_id, string content) {
         Comment   toAdd = new Comment();

         toAdd.m_user_id = to!string(uid);
         toAdd.m_dream_id = to!string(dream_id);
         toAdd.m_content = content;
         return (_commentRes.add(toAdd));
     }

     /**
      * Hashtag resource
      */

      // GET /api/hashtag
      Hashtag[]  getHashtag() {
          return (_hashtagRes.all());
      }

      // GET /api/hashtag/:uid
      Hashtag    getHashtag(uint _uid) {
          return (_hashtagRes.find(_uid));
      }

      // GET /api/hashtag/bydreamid/:dream_id
      Hashtag[]  getHashtagByDreamId(uint _dream_id) {
          return (_hashtagRes.findCustomKey!uint("dream_id", _dream_id));
      }

     // GET /api/hashtag/byuserid/:uid
      Hashtag[]  getHashtagByUserId(uint _uid) {
          return (_hashtagRes.findCustomKey!uint("user_id", _uid));
      }

      // DELETE /api/hashtag
      bool   deleteHashtag(uint _uid) {
          return (_hashtagRes.del(_uid));
      }

      // POST /api/hashtag
      bool   postHashtag(uint uid, uint dream_id, string content) {
          Hashtag   toAdd = new Hashtag();

          toAdd.m_user_id = to!string(uid);
          toAdd.m_dream_id = to!string(dream_id);
          toAdd.m_content = content;
          return (_hashtagRes.add(toAdd));
      }
}
