class User {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String bio;
  final String profileImgUrl;
  final List favourites;

  User({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.bio,
    required this.profileImgUrl,
    required this.favourites,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'] ??= "",
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'] ??= "",
      profileImgUrl: json['profileImgUrl'] ??= "",
      favourites: json['favourites'],
    );
  }
}
