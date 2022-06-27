class User {
  String id;
  String? email;
  String? name;
  String? password;
  String? phoneNumber;

  User({
    required this.id,
    required this.email,
    this.name,
    this.password,
    this.phoneNumber,
  });
}
