int main(string[] ac) {
  unittest {
    Dream tmp = new Dream();
    tmp.m_id = "0";
    tmp.m_user_id = "2";
    tmp.m_category_id = "3";
    tmp.m_content = "lool";
    tmp.m_date = "0000-00-00";
    assert(tmp.asDefinition == "user_id=2,category_id=3,content=\"lool\",date=0000-00-00");
  }
}
