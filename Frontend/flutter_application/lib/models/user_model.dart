class User {
  final String email;
  final String studioName;
 
  const User({
    required this.email,
    required this.studioName,
  });
 
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      studioName: json['studio_name'],
    );
  }
}