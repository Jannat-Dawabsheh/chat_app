class ApiPath{
  static String allUser() => 'user/';
  static String user(String id) => 'user/$id';
  static String sendMessage(String id) => 'message/$id';
  static String message() => 'message/';
  static String addConversation(String uid, String convid) => 'user/$uid/Conversation/$convid';
  static String conversation() => 'addConversation/';
  static String addConversations(String id) => 'addConversation/$id';
  static String getPrivateConv(String uid) => 'user/$uid/Conversation/';
}
  