class UserData {
  final String id;
  final String email;
  final String username;
  final String password;
  final String photoUrl;


  UserData({required this.id, required this.email, required this.username, required this.password,required this.photoUrl});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'username': username});
    result.addAll({'password': password});
    result.addAll({'photoUrl': photoUrl});
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }
}

List<UserData> users=[
  UserData(id: '1', email: 'email', username: 'username', password: 'password', photoUrl: 'https://static.vecteezy.com/system/resources/previews/014/194/216/original/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg'),
  UserData(id: '2', email: 'email', username: 'name', password: 'password', photoUrl: 'https://static.vecteezy.com/system/resources/previews/014/194/216/original/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg'),
];
