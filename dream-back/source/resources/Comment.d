import  std.conv;

import  mysql;

class Comment
{
    string  m_id;
    string  m_user_id;
    string  m_dream_id;
    string  m_content;
    string  m_post_date = "CURRENT_TIMESTAMP";

    this() {
        m_id = "-1";
    }

    this(string[string] aa) {
        m_user_id = aa["user_id"];
        m_dream_id = aa["dream_id"];
        m_content = aa["content"];
        m_post_date = aa["post_date"];
    }

    this(string _content, string _date, string _did) {
        m_content = _content;
        m_post_date = _date;
        m_dream_id = _did;
    }

    this(DBValue[string] aa) {
        m_id = to!string(aa["id"].value);
        m_content = to!string(aa["content"].value);
        m_post_date = to!string(aa["post_date"].value);
        m_dream_id = to!string(aa["dream_id"].value);
        m_user_id = to!string(aa["user_id"].value);
    }

    @property string asValues()
    {
        return ("(" ~
                m_user_id ~ " " ~
                m_dream_id ~ " "  ~
                m_content ~ " " ~
                m_post_date ~ " " ~
                ")");
    }
}
