class ApiPath{
  static String allUser() => 'user/';
  static String user(String id) => 'user/$id';
  static String sendMessage(String id) => 'message/$id';
  static String message() => 'message/';
}