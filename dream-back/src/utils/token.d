module  utils.token;

import  std.digest.sha;
import  std.random;
import  std.datetime;
import  std.conv;

class   Token {

  private {
    string  _token;
    uint    _userId;
    SysTime _generationTime;
  }

  this(uint userId) {
    _userId = userId;
    _generationTime = Clock.currTime();
    _token = Token.generateRandomString();
  }

  static string  generateRandomString() {
    auto   randomNumber = uniform(uniform(0, 999), Clock.currStdTime());

    SHA1 hash;
    hash.start();
    hash.put(cast(ubyte)randomNumber);
    ubyte[20] token = hash.finish();
    return (to!string(token));
  }

  string  refreshToken() {
    _token = Token.generateRandomString();
    return (_token);
  }

  uint  getUid() {
    return (_userId);
  }

  string getToken() {
    return (_token);
  }

  void setToken(string token) {
    _token = token;
  }

  void setUid(uint uid) {
    _userId = uid;
  }
}
