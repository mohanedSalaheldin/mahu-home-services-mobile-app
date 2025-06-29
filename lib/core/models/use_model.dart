class UserModel {
  final String id;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final UserProfile profile;

  UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      isVerified: json['isVerified'],
      profile: UserProfile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
      'profile': profile.toJson(),
    };
  }
}

class UserProfile {
  final String firstName;
  final String lastName;

  UserProfile({
    required this.firstName,
    required this.lastName,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
