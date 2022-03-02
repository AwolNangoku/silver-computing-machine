class User {
  final String firstname;
  final String lastname;
  final String emailAddress;
  final String password;
  final String mobileNumber;
  final String idNumber;
  final String bio;

  const User(
      {required this.firstname,
      required this.lastname,
      required this.emailAddress,
      required this.password,
      required this.mobileNumber,
      required this.idNumber,
      required this.bio});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstname: json['firstname'],
        lastname: json['lastname'],
        emailAddress: json['emailAddress'],
        password: json['password'],
        mobileNumber: json['mobileNumber'],
        idNumber: json['idNumber'],
        bio: json['bio']);
  }
}
