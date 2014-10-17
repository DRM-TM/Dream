import  std.conv;

import  mysql;

class Comment
{
    string  id;
    string  user_id;
    string  dream_id;
    string  content;
    string  post_date;

    this() {
        id = "-1";
    }

    this(string _content, string _date, string _did) {
        content = _content;
        post_date = _date;
        dream_id = _did;
    }

    this(DBValue[string] aa) {
        id = to!string(aa["id"].value);
        content = to!string(aa["content"].value);
        post_date = to!string(aa["post_date"].value);
        dream_id = to!string(aa["dream_id"].value);
        user_id = to!string(aa["user_id"].value);
    }

}
