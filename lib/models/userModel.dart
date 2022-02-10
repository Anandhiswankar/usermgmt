class User {
  final int? id;
  final String name;
  final String dob;
  final String password;
  final String? email;

  User(
      {this.id,
      required this.name,
      required this.dob,
      required this.password,
      this.email});

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        dob = res["dob"],
        password = res["password"],
        email = res["email"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'dob': dob,
      'password': password,
      'email': email
    };
  }
}
