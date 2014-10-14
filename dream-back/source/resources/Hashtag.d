import  std.conv;

import  mysql;

class Hashtag
{
    string  id;
    string  user_id;
    string  dream_id;
    string  content;

    this() {
        id = "-1";
    }

    this(string _content) {
        content = _content;
    }

    this(DBValue[string] aa) {
        id = to!string(aa["id"].value);
        content = to!string(aa["content"].value);
        dream_id = to!string(aa["dream_id"].value);
        user_id = to!string(aa["user_id"].value);
    }
}
