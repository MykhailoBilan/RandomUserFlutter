class User {
  String gender;
  String firstname;
  String lastname;
  String country;
  String city;
  String email;
  String cell;
  String picture;
  User({
    required this.gender,
    required this.firstname,
    required this.lastname,
    required this.country,
    required this.city,
    required this.email,
    required this.cell,
    required this.picture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        gender: json['gender'] as String,
        firstname: json['name']['first'] as String,
        lastname: json['name']['last'] as String,
        country: json['location']['country'] as String,
        city: json['location']['city'] as String,
        email: json['email'] as String,
        cell: json['cell'] as String,
        picture: json['picture']['medium'] as String);
  }
}
