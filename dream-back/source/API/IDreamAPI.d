import      mysql;
import      vibe.d;
import      vibe.web.common;

import      Dream;
import      User;

@rootPath("api")
interface   IDreamAPI
{
    /**
     * Bullshit stuff for debug purpose ONLY
     */

    // GET /api/bullshit_users
    User*   getBullshitUsers();

    // GET /api/bullshit_dreams
    Dream*  getBullshitDreams();

    /**
     * User resource
     */

    // GET /api/user
    User[]  getUser();

    // GET /api/user/:uid
    @path("user/:uid")
    User    getUser(uint _uid);

    // POST /api/user
    void    postUser(string email, string password);

    // DELETE /api/user/:uid
    @path("user/:uid")
    User    deleteUser(uint _uid);

    /**
     * Dream resource
     */

    // GET /api/dream
    Dream[] getDream();

    // GET /api/dream/:uid
    @path("dream/:uid")
    Dream   getDream(uint _uid);

    // GET /api/dream/category/:category_id
    @path("dream/category/:category_id")
    Dream[]  getDream(string categoryzz);

    // POST /api/dream
    void    postDream();

    // DELETE /api/dream/:uid
    @path("dream/:uid")
    Dream    deleteDream(uint _uid);
}
