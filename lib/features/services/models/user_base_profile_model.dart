class UserBaseProfileModel {
  final String firstName;
  final String id;
  final String lastName;
  final String avatar;
  final String name;
  final String? email; // Optional
  final String? phone; // Optional
  final String businessName; // Optional

  UserBaseProfileModel({
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.avatar,
    required this.name,
    this.email,
    this.phone,
    required this.businessName,
  });

  factory UserBaseProfileModel.fromJson(Map<String, dynamic> json) {
    return UserBaseProfileModel(
      firstName: json['firstName'] ?? '',
      id: json['id'] ?? '',
      lastName: json['lastName'] ?? '',
      avatar: json['avatar'] ?? '',
      name: json['name'] ?? '',
      businessName: json['businessName'] ?? '',
      email: json['email'], // Nullable
      phone: json['phone'], // Nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'businessName': businessName,
      'avatar': avatar,
      'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
    };
  }

  // For updating fields easily
  UserBaseProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? avatar,
    String? name,
    String? businessName,
    String? email,
    String? phone,
  }) {
    return UserBaseProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      businessName: businessName ?? this.businessName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
