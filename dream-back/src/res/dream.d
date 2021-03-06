module  res.dream;

import  std.conv;

import  mysql;

class Dream
{
    string  m_id;
    string  m_user_id;
    string  m_category_id;
    string  m_content;
    string  m_likes;

    this() {
        m_id = "-1";
        m_likes = "0";
    }

    this(string[string] aa) {
        m_user_id = aa["user_id"];
        m_category_id = aa["category_id"];
        m_content = aa["content"];
        m_likes = aa["likes"];
    }

    this(string _content, string _category, string _likes) {
        m_content = _content;
        m_category_id = _category;
        m_likes = _likes;
    }

    this(DBValue[string] aa) {
        m_id = to!string(aa["id"].value);
        m_content = to!string(aa["content"].value);
        m_category_id = to!string(aa["category_id"].value);
        m_user_id = to!string(aa["user_id"].value);
        m_likes = to!string(aa["likes"].value);
    }

    @property string content() {
        return (m_content);
    }

    @property string asValues()
    {
        return ("(" ~
                m_user_id ~ ", " ~
                m_category_id ~ ", "
                ~ "\"" ~ m_content ~ "\", " ~
                m_likes ~
                ")");
    }

    @property string asDefinition()
    {
      return (
        "user_id=" ~ m_user_id ~ ","
        "category_id=" ~ m_category_id ~ ","
        "content=\"" ~ m_content ~ "\","
        "likes=" ~ m_likes
      );
    }
}
