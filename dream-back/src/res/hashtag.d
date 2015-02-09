module  res.hashtag;

import  std.conv;

import  mysql;

class Hashtag
{
    string  m_id;
    string  m_user_id;
    string  m_dream_id;
    string  m_content;

    this() {
        m_id = "-1";
    }

    this(string _content) {
        m_content = _content;
    }

    this(string[string] aa) {
        m_user_id = aa["user_id"];
        m_dream_id = aa["dream_id"];
        m_content = aa["content"];
    }

    this(DBValue[string] aa) {
        m_id = to!string(aa["id"].value);
        m_content = to!string(aa["content"].value);
        m_dream_id = to!string(aa["dream_id"].value);
        m_user_id = to!string(aa["user_id"].value);
    }

    @property string asValues()
    {
        return ("(" ~
                m_user_id ~ ", " ~
                m_dream_id ~ ", "  ~
                "\"" ~ m_content ~ "\"" ~
                ")");
    }

    @property string asDefinition()
    {
      return (
        "user_id=" ~ m_user_id ~ ","
        "dream_id=" ~ m_dream_id ~ ","
        "content=\"" ~ m_content ~ "\""
      );
    }
}
