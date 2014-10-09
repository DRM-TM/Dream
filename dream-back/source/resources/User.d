import  mysql;
import  std.conv;

class User
{
    string  id;
    string  email;
    string  password;
    string  inscription_date;
    string  last_connection;
    string  user_token;
    string  birthdate;

    this() {
        id = "-1";
    }

    this(string _email, string _password) {
        email = _email;
        password = _password;
    }

    this(DBValue[string] aa)
    {
        id = to!string(aa["id"].value);
        email = to!string(aa["email"].value);
        password = to!string(aa["password"].value);
        inscription_date = to!string(aa["inscription_date"].value);
        last_connection = to!string(aa["last_connection"].value);
        user_token = to!string(aa["user_token"].value);
        birthdate = to!string(aa["birthdate"].value);
    }
}
