import      mysql;
import      vibe.d;
import      vibe.web.common;

import      Dream;
import      User;
import      Comment;
import      Hashtag;

@rootPath("api")
interface   IDreamAPI
{
    /**
     * User resource
     */

    // GET /api/user
    User[]  getUser();

    // GET /api/user/:uid
    @path("user/:uid")
    User    getUser(uint _uid);

    // POST /api/user
    void    postUser(string email, string password, string token, string birthdate);

    // DELETE /api/user
    void    deleteUser(uint uid);

    /**
     * Dream resource
     */

    // GET /api/dream
    Dream[] getDream();

    // GET /api/dream/:uid
    @path("dream/:uid")
    Dream   getDream(uint _uid);

    // GET /api/dream/incategory/:category_id
    @path("dream/incategory/:cat_id")
    Dream[]  getDreamIncategory(uint _cat_id);

    // POST /api/dream
    void    postDream(uint uid, uint category_id, string content);

    // DELETE /api/dream
    void    deleteDream(uint uid);

    /*
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
     void   deleteComment(uint uid);

     // POST /api/comment
     void   postComment(uint uid, uint dream_id, string content);

     /*
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
      void   deleteHashtag(uint uid);

      // POST /api/hashtag
      void   postHashtag(uint uid, uint hashtag_id, string content);
}
