import  mysql;
import  std.conv;

class User
{
    string          m_id;
    string          m_email;
    string          m_password;
    string          m_username;
    string          m_user_token;
    string          m_inscription_date = "CURRENT_TIMESTAMP";
    string          m_last_connection = "CURRENT_TIMESTAMP";
    string          m_birthdate = "CURRENT_TIMESTAMP";

    this() {
        m_id = "-1";
    }

    this(string[string] aa) {
        m_email = aa["email"];
        m_password = aa["password"];
        m_username = aa["username"];
        m_inscription_date = aa["inscription_date"];
        m_last_connection = aa["last_connection"];
        m_user_token = aa["user_token"];
        m_birthdate = aa["birthdate"];
    }

    this(DBValue[string] aa)
    {
        m_id = to!string(aa["id"].value);
        m_email = to!string(aa["email"].value);
        m_password = to!string(aa["password"].value);
        m_username = to!string(aa["username"].value);
        m_inscription_date = to!string(aa["inscription_date"].value);
        m_last_connection = to!string(aa["last_connection"].value);
        m_user_token = to!string(aa["user_token"].value);
        m_birthdate = to!string(aa["birthdate"].value);
    }

    @property string asValues()
    {
        return (
            "(" ~
                    "\"" ~ m_email ~ "\"," ~
                    "\"" ~ m_password ~ "\"," ~
                    "\"" ~ m_username ~ "\","  ~
                    "\"" ~ m_user_token ~ "\"," ~
                    m_inscription_date ~ "," ~
                    m_last_connection ~ "," ~
                    "\"" ~ m_birthdate ~ "\""
            ")"
        );
    }
}
