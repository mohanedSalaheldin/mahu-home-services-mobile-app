class UserBaseProfileModel {
  final String firstName;
  final String lastName;
  final String avatar;

  UserBaseProfileModel({
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserBaseProfileModel.fromJson(Map<String, dynamic> json) {
    return UserBaseProfileModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }
}
