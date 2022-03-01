class User {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String bio;

  const User(
      {required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.bio});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['username'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      bio: json['bio'],
    );
  }
}
