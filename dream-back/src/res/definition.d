module  res.definition;

import  std.conv;

import  mysql;

class Definition
{
    string          m_id;
    string          m_word;
    string          m_definition;


    this() {
        m_id = "-1";
    }

    this(string[string] aa) {
        m_word = aa["word"];
        m_definition = aa["definition"];
    }

    this(DBValue[string] aa) {
        m_id = to!string(aa["id"].value);
        m_word = to!string(aa["word"].value);
        m_definition = to!string(aa["definition"].value);
    }

    @property string asValues()
    {
        return (
            "(" ~
                    "\"" ~ m_word ~ "\"," ~
                    "\"" ~ m_definition ~ "\""
            ")"
        );
    }

    bool opEquals(in Definition rhs) const
    {
        return m_word == rhs.m_word;
    }

    bool opEquals(in string rhs) const
    {
        return m_word == rhs;
    }
}
