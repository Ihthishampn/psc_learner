class UserModel {
  // sign up model
  final String uid;
  final String username;
  final String email;

  UserModel( {required this.username, required this.email,required this.uid,});

  Map<String, dynamic> toMap() {
    return {'username': username, 'email': email};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(username: map['username'], email: map['email'],uid: map['uid']);
  }
}
