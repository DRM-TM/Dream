import      mysql;
import      vibe.d;
import      vibe.web.common;

import      Dream;
import      User;

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
    @path("dream/incategory/:uid")
    Dream[]  getDreamIncategory(uint _uid);

    // POST /api/dream
    void    postDream(uint uid, uint category_id, string content);

    // DELETE /api/dream
    void    deleteDream(uint uid);
}
