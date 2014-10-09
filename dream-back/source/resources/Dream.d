import  std.conv;

import  mysql;

class Dream
{
    string  id;
    string  user_id;
    string  category_id;
    string  content;
    string  date;

    this() {
        id = "-1";
    }

    this(string _content, string _date, string _category) {
        content = _content;
        date = _date;
        category_id = _category;
    }

    this(DBValue[string] aa) {
        id = to!string(aa["id"].value);
        content = to!string(aa["content"].value);
        date = to!string(aa["date"].value);
        category_id = to!string(aa["category_id"].value);
        user_id = to!string(aa["user_id"].value);
    }
}
