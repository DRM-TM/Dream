module  res.word;

import  std.conv;

import  mysql;

class Word
{
    string          m_id;
    string          m_word;
    string          m_level;

    this() {
        m_id = "-1";
    }

    this(string[string] aa) {
        m_word = aa["word"];
        m_level = aa["level"];
    }

    this(DBValue[string] aa) {
        m_id = to!string(aa["id"].value);
        m_word = to!string(aa["word"].value);
        m_level = to!string(aa["level"].value);
    }

    @property string asValues()
    {
        return (
            "(" ~
                    "\"" ~ m_word ~ "\"," ~
                    "\"" ~ m_level ~ "\""
            ")"
        );
    }

    bool opEquals(in Word rhs) const
    {
        return m_word == rhs.m_word;
    }

    bool opEquals(in string rhs) const
    {
        return m_word == rhs;
    }
}
