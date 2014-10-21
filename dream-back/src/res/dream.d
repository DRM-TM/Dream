module  res.dream;

import  std.conv;

import  mysql;

class Dream
{
    string  m_id;
    string  m_user_id;
    string  m_category_id;
    string  m_content;
    string  m_date = "CURRENT_TIMESTAMP";

    this() {
        m_id = "-1";
    }

    this(string[string] aa) {
        m_user_id = aa["user_id"];
        m_category_id = aa["category_id"];
        m_content = aa["content"];
        m_date = aa["date"];
    }

    this(string _content, string _date, string _category) {
        m_content = _content;
        m_date = _date;
        m_category_id = _category;
    }

    this(DBValue[string] aa) {
        m_id = to!string(aa["id"].value);
        m_content = to!string(aa["content"].value);
        m_date = to!string(aa["date"].value);
        m_category_id = to!string(aa["category_id"].value);
        m_user_id = to!string(aa["user_id"].value);
    }

    @property string asValues()
    {
        return ("(" ~
                m_user_id ~ " " ~
                m_category_id ~ " "  ~
                m_content ~ " " ~
                m_date ~ " " ~
                ")");
    }
}
