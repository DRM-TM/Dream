/**

    This module is the interface describing the RESTful API functionalities.
    It Contains every functions sorted by resources and collections.
    The API contains the following:
    Resources:
        - Dream
        - User
        - Comment
        - Hashtag
    Collections:
        - Fdream

    Copyright: © 2014 Julien Ganichot
    Authors: Julien Ganichot
 */

module      api.desc;

import      std.container;

import      mysql;

import      vibe.d;

import      res.user;
import      res.comment;
import      res.hashtag;
import      res.dream;
import      res.word;
import      res.definition;

import      col.fdream;

@rootPath("api")
interface   IDreamAPI
{
    // POST /api/search
    @path("search")
    SList!Fdream postSearch(string research);

    /**
     * User resource
     * Every functions related to the User resources.
     */

    /***********************************
     * This function ask the database to get every users
     *
     * Route: GET /api/user/:uid
     */
    User[]  getUser();

    /***********************************
     * This function ask the database to get the user corresponding to
     * the id=uid
     *
     * Route: GET /api/user/:uid
     */
    @path("user/:uid")
    User    getUser(uint _uid);

    /***********************************
     * This function add a user to the database
     *
     * Route: POST /api/user
     */
    bool    postUser(string email, string password, string token, string birthdate, string username);

    @path("user/login")
    string  postUserAuth(string email, string hash);

    @path("user/login/token")
    bool    postUserAuth(string email, string hash, string token);

    /***********************************
     * This function add a user to the database
     *
     * Route: DELETE /api/user
     */
    @path("user/:uid")
    bool    deleteUser(uint _uid);

    /**
     * Dream resource
     */

    /***********************************
     * This function ask the database to get every users from it.
     *
     * Route: GET /api/dream
     */
    Fdream[]    getDream();

    // GET /api/dream/:uid
    @path("dream/:uid")
    Dream   getDream(uint _uid);

    // GET /api/dream/incategory/:category_id
    @path("dream/incategory/:cat_id")
    Dream[]  getDreamIncategory(uint _cat_id);

    // GET /api/dream/limit/:limit
    @path("dream/limit/:limit")
    Fdream[] getDreamLimit(uint _limit);

    // POST /api/dream
    bool    postDream(uint uid, uint category_id, string content);

    // DELETE /api/dream
    @path("dream/:uid")
    bool    deleteDream(uint _uid);

    // PUT /api/dream
    bool  putDream(uint actual_id, uint uid, uint category_id, string content);

    /**
     * Comment resource
     */

     // GET /api/comment
     Comment[]  getComment();

     // GET /api/comment/:uid
     Comment    getComment(uint _uid);

     // GET /api/comment/bydreamid/:dream_id
     @path("comment/bydreamid/:dream_id")
     Comment[]  getCommentByDreamId(uint _dream_id);

    // GET /api/comment/byuserid/:uid
    @path("comment/byuserid/:uid")
     Comment[]  getCommentByUserId(uint _uid);

     // DELETE /api/comment
     @path("comment/:uid")
     bool   deleteComment(uint _uid);

     // POST /api/comment
     bool   postComment(uint uid, uint dream_id, string content);

     // PUT /api/comment
     bool  putComment(uint actual_id, uint uid, uint dream_id, string content);

     /**
      * Hashtag resource
      */

      // GET /api/hashtag
      Hashtag[]  getHashtag();

      // GET /api/hashtag/:uid
      Hashtag    getHashtag(uint _uid);

      // GET /api/hashtag/bydreamid/:dream_id
      @path("hashtag/bydreamid/:dream_id")
      Hashtag[]  getHashtagByDreamId(uint _dream_id);

     // GET /api/hashtag/byuserid/:uid
     @path("hashtag/byuserid/:uid")
      Hashtag[]  getHashtagByUserId(uint _uid);

      // DELETE /api/hashtag
      @path("hashtag/:uid")
      bool   deleteHashtag(uint _uid);

      // POST /api/hashtag
      bool   postHashtag(uint uid, uint dream_id, string content);

      // PUT /api/hashtag
      bool  putHashtag(uint actual_id, uint uid, uint dream_id, string content);

      /**
      * Word resource
      */

      // GET /api/word
      Word[]  getWord();

      // GET /api/word/:uid
      Word    getWord(uint _uid);

      // GET /api/word/bystring/:actual_word
      @path("word/bystring/:actual_word")
      Word[]  getWordsByString(string _actual_word);

      // GET /api/word/bylevel/:level
      @path("word/bystring/:actual_word")
      Word[]  getWordsByLevel(uint _level);

      // DELETE /api/word
      @path("word/:uid")
      bool   deleteWord(uint _uid);

      // POST /api/word
      bool   postWord(string word, uint level);

      // PUT /api/word
      bool  putWord(uint actual_id, string word, uint level);


      /**
      * Definition resource
      */

      // GET /api/definition
      Definition[]  getDefinition();

      // GET /api/definition/:uid
      Definition    getDefinition(uint _uid);

      // GET /api/definition/:actual_word
      @path("definition/byword/:actual_word")
      Definition[]  getDefinitionsByWord(string _actual_word);

      // DELETE /api/definition
      @path("definition/:uid")
      bool   deleteDefinition(uint _uid);

      // POST /api/definition
      bool   postDefinition(string word, string definition);

      // PUT /api/definition
      bool  putDefinition(uint actual_id, string word, string definition);

      /*
      * Reporter
      */

      // POST /api/dream/report
      @path("dream/report/:uid")
      Fdream postReportDream(uint _uid);

      // POST /api/dream/check/forbiden
      @path("dream/check/forbiden")
      SList!Word  postCheckForbiden(string text);

      //POST /api/dream/check/meaning
      @path("dream/check/meaning")
      SList!Definition postCheckMeaning(string text);
}
