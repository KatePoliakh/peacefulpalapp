class UserProfile {
  final int? id;
  final String email;
  final String password;

  UserProfile({this.id, required this.email, required this.password});

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'password': password,
  };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
    id: map['id'],
    email: map['email'],
    password: map['password'],
  );
}
