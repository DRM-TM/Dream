module  res.reported;

import  std.conv;

import  mysql;

class Reported
{
  string  m_id;
  string  m_dream_id;
  string  m_user_id;

  this() {
      m_id = "-1";
  }

  this(string[string] aa) {
      m_user_id = aa["user_id"];
      m_dream_id = aa["dream_id"];
  }

  this(string _dream_id, string _user_id) {
      m_dream_id = _dream_id;
      m_user_id = _user_id;
  }

  this(DBValue[string] aa) {
      m_id = to!string(aa["id"].value);
      m_dream_id = to!string(aa["dream_id"].value);
      m_user_id = to!string(aa["user_id"].value);
  }
  
  @property string asValues()
  {
      return ("(" ~
              m_dream_id ~ ", " ~
              m_user_id ~
              ")");
  }

  @property string asDefinition()
  {
    return (
      "dream_id=" ~ m_dream_id ~ ","
      "user_id=" ~ m_user_id
    );
  }
}
