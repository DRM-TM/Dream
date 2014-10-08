import  std.conv;
import  mysql;

class Dream
{
    string  id;
    string  content;
    string  date;

    this() {

    }

    this(string _content, string _date) {
        content = _content;
        date = _date;
    }

    this(DBValue[string] aa) {
        id = to!string(aa["id"].value);
        content = to!string(aa["content"].value);
        date = to!string(aa["date"].value);
    }
}
