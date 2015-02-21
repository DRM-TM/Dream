module  api.impl;

import	std.stdio;
import  std.conv;
import  std.regex;
import  std.container;
import  std.range;

import	mysql.connection;

import  vibe.d;

import  res.user;
import  res.comment;
import  res.hashtag;
import  res.dream;
import  res.word;
import  res.definition;
import  res.reported;

import  utils.token;

import  col.fdream;
import  col.freported;

import  api.desc;
import 	db.model;

class   DreamAPI : IDreamAPI
{
    private {
        SList!Token               _tokens;

        string                    _connStr;
        Connection                _dbCon;

        Model!(User, uint)        _userRes;
        Model!(Dream, uint)       _dreamRes;
        Model!(Comment, uint)     _commentRes;
        Model!(Hashtag, uint)     _hashtagRes;
        Model!(Word, uint)        _wordRes;
        Model!(Definition, uint)  _definitionRes;
        Model!(Reported, uint)    _reportedRes;

        Secrets                   _secrets;
    }

    this(string connStr)
    {
        _connStr = connStr;
        _tokens = make!(SList!Token);
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
        _wordRes = new Model!(Word, uint)(_dbCon);
        _definitionRes = new Model!(Definition, uint)(_dbCon);
        _reportedRes = new Model!(Reported, uint)(_dbCon);
        _secrets.facebook_id = "1485303221747100";
        _secrets.facebook_secret = "d0f4b735b711f558a00d3c5af99d22c8";
    }

    Secrets getSecrets() {
      return (_secrets);
    }

    Token findTokenForUser(uint userId) {
      foreach (token ; _tokens) {
        if (token.getUid() == userId) {
          return (token);
        }
      }
      return (null);
    }

    Token findTokenForToken(string userToken) {
      foreach (token ; _tokens) {
        if (token.getToken() == userToken) {
          return (token);
        }
      }
      return (null);
    }

    bool  isAllowed(string token) {
      return ((findTokenForToken(token) is null) ? false : true);
    }

    //POST /dream/check/forbiden
    SList!Word  postCheckForbiden(string text) {
      Word[]      dbContent = getWord();
      string[]    wordtab = text.split();
      SList!Word  forbidenWords = make!(SList!Word);

      if (wordtab is null) {
        throw new HTTPStatusException(418); // Means "I'm a teapot"
      }
      foreach (word ; wordtab) {
        foreach (dbWord ; dbContent) {
          if (word == dbWord) {
            forbidenWords.insert(dbContent);
          }
        }
      }
      if (walkLength(forbidenWords[]) <= 0)
        throw new HTTPStatusException(204);
      return (forbidenWords);
    }

    //POST /dream/check/meaning
    SList!Definition postCheckMeaning(string text) {
      Definition[]      dbContent = getDefinition();
      string[]          wordtab = text.split();
      SList!Definition  definitions = make!(SList!Definition);

      if (wordtab is null) {
        throw new HTTPStatusException(418); // Means "I'm a teapot"
      }
      foreach (word ; wordtab) {
        foreach (dbDefinition ; dbContent) {
          if (word == dbDefinition) {
            definitions.insert(dbContent);
          }
        }
      }
      if (walkLength(definitions[]) <= 0)
        throw new HTTPStatusException(204);
      return (definitions);
    }

    // POST /search
    SList!Fdream  postSearch(string research) {
      auto ret = matchAll(research, regex(`\w+`));
      Fdream[] dreams = getDream();
      auto list = make!(SList!Fdream);

      foreach (dream ; dreams) {
        foreach (word ; ret) {
          auto re = regex(r"(" ~ word.hit ~ ")", "gi");
          auto check = matchAll(dream.content.content, re);
          if (!check.empty) {
            list.insert(dream);
          }
        }
      }
      if (walkLength(list[]) <= 0) {
        throw new HTTPStatusException(204);
      }
      return (list);
    }

    /**
     * User resource methods
     */

    // GET /user
    User[]  getUser() {
        return (_userRes.all());
    }

    // GET /user/:uid
    User    getUser(uint _uid) {
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

    bool  putUser(uint actual_id, string email, string password, string token, string birthdate, string username) {
      User   toUpdate = new User();

      toUpdate.m_id = to!string(actual_id);
      toUpdate.m_email = email;
      toUpdate.m_password = password;
      toUpdate.m_username = username;
      toUpdate.m_user_token = token;
      toUpdate.m_birthdate = birthdate;
      return (_userRes.update(toUpdate));
    }

    // POST /user/login
    User    postUserAuth(string email, string hash) {
      User[]  match = _userRes.findCustomKey!(string)("email", "\"" ~ email ~ "\"");

      if (match.length > 1 || match.length == 0) {
        throw new HTTPStatusException(401);
      }
      if (match[0].m_email == email && match[0].m_password == hash) {
        return (match[0]);
      }
      throw new HTTPStatusException(401);
    }

    // POST /user/login/token
    bool    postUserAuth(string email, string hash, string token) {
      User[]  match = _userRes.findCustomKey!(string)("email", "\"" ~ email ~ "\"");

      if (match.length > 1 || match.length == 0) {
        //throw new HTTPStatusException(401);
        return (false);
      }
      if (match[0].m_email == email && match[0].m_user_token == token) {
        return (true);
      }
      return (false);
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

    Freported solveReported(Reported base) {
      Freported  ret = new Freported();

      ret.m_content = getDream(to!uint(base.m_dream_id));
      ret.m_user = getUser(to!uint(base.m_user_id));
      ret.m_base = base;
      return (ret);
    }

    // GET /api/dream/reported
    Freported[]  getReported() {
      Reported[]  result = _reportedRes.all();
      Freported[] reportedDreams = new Freported[to!uint(result.length)];

      for (auto i = 0 ; i < result.length ; ++i) {
        reportedDreams[i] = solveReported(result[i]);
      }
      return (reportedDreams);
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
        dreams.reverse;
        return (dreams);
    }

    // POST /api/dream/like/:uid
    bool   postLike(uint _uid) {
      Dream liked = getDream(_uid);
      uint  tmp = 0;

      if (liked is null)
        throw new HTTPStatusException(204);
      liked.m_likes = to!string(to!uint(liked.m_likes) + 1);
      return (_dreamRes.update(liked));
    }

    // GET /api/dream/:uid
    Dream   getDream(uint _uid) {
        return (_dreamRes.find(_uid));
    }

    // GET /api/dream/limit/:limit
    Fdream[] getDreamLimit(uint _limit) {
      Dream[] result;
      _dreamRes.limit = _limit;
      result = _dreamRes.all();
      Fdream[]    dreams = new Fdream[to!uint(result.length)];

      for (auto i = 0 ; i < result.length ; ++i) {
          dreams[i] = solveDream(result[i]);
      }
      _dreamRes.limit = 0;
      return (dreams);
    }

    // POST /dream
    bool    postDream(uint uid, uint category_id, string content) {
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

    // PUT /api/dream
    bool  putDream(uint actual_id, uint uid, uint category_id, string content) {
      Dream   toUpdate = new Dream();

      toUpdate.m_id = to!string(actual_id);
      toUpdate.m_user_id = to!string(uid);
      toUpdate.m_category_id = to!string(category_id);
      toUpdate.m_content = content;
      return (_dreamRes.update(toUpdate));
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

     // PUT /api/comment
     bool  putComment(uint actual_id, uint uid, uint dream_id, string content) {
       Comment   toUpdate = new Comment();

       toUpdate.m_id = to!string(actual_id);
       toUpdate.m_user_id = to!string(uid);
       toUpdate.m_dream_id = to!string(dream_id);
       toUpdate.m_content = content;
       return (_commentRes.update(toUpdate));
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

      // PUT /api/hashtag
      bool  putHashtag(uint actual_id, uint uid, uint dream_id, string content) {
        Hashtag   toUpdate = new Hashtag();

        toUpdate.m_id = to!string(actual_id);
        toUpdate.m_user_id = to!string(uid);
        toUpdate.m_dream_id = to!string(dream_id);
        toUpdate.m_content = content;
        return (_hashtagRes.update(toUpdate));
      }

      /**
      * Word resource
      */

      // GET /api/word
      Word[]  getWord() {
        return (_wordRes.all());
      }

      // GET /api/word/:uid
      Word    getWord(uint _uid) {
        return (_wordRes.find(_uid));
      }

      // GET /api/word/bystring/:actual_word
      Word[]  getWordsByString(string _actual_word) {
        return (_wordRes.findCustomKey!string("word", _actual_word));
      }

      // GET /api/word/bylevel/:level
      Word[]  getWordsByLevel(uint _level) {
        return (_wordRes.findCustomKey!uint("level", _level));
      }

      // DELETE /api/word
      bool   deleteWord(uint _uid) {
        return (_wordRes.del(_uid));
      }

      // POST /api/word
      bool   postWord(string word, uint level) {
        Word  toAdd = new Word();

        toAdd.m_id = "-1";
        toAdd.m_word = word;
        toAdd.m_level = to!string(level);
        return (_wordRes.add(toAdd));
      }

      // PUT /api/word
      bool  putWord(uint actual_id, string word, uint level) {
        Word toUpdate = new Word();

        toUpdate.m_id = to!string(actual_id);
        toUpdate.m_word = word;
        toUpdate.m_level = to!string(level);
        return (_wordRes.update(toUpdate));
      }

      /**
      * Definition resource
      */

      // GET /api/definition
      Definition[]  getDefinition() {
        return (_definitionRes.all());
      }

      // GET /api/definition/:uid
      Definition    getDefinition(uint _uid) {
        return (_definitionRes.find(_uid));
      }

      // GET /api/definition/byword/:actual_word
      Definition[]  getDefinitionsByWord(string _actual_word) {
        return (_definitionRes.findCustomKey!string("word", _actual_word));
      }

      // DELETE /api/definition
      bool   deleteDefinition(uint _uid) {
        return (_definitionRes.del(_uid));
      }

      // POST /api/definition
      bool   postDefinition(string word, string definition) {
        Definition toAdd = new Definition();

        toAdd.m_word = word;
        toAdd.m_definition = definition;
        return (_definitionRes.add(toAdd));
      }

      // PUT /api/definition
      bool  putDefinition(uint actual_id, string word, string definition) {
        Definition toUpdate = new Definition();

        toUpdate.m_id = to!string(actual_id);
        toUpdate.m_word = word;
        toUpdate.m_definition = definition;
        return (_definitionRes.add(toUpdate));
      }

      /*
      * Reporter
      */

      // POST /api/dream/report/:_uid
      Fdream postReportDream(uint _uid) {
        Dream tmp = _dreamRes.find(_uid);
        if (tmp is null)
          throw new HTTPStatusException(418);
        Reported rep = new Reported();
        rep.m_user_id = tmp.m_user_id;
        rep.m_dream_id = tmp.m_id;
        _reportedRes.add(rep);
        return (solveDream(tmp));
      }
}
