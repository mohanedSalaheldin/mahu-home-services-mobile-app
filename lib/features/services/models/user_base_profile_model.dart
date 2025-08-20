class UserBaseProfileModel {
  final String firstName;
  final String lastName;
  final String avatar;
  final String id;
  final String? name;
  final String? email;
  final String? phone;
  final String businessName;
  final String businessRegistration;
  final String? serviceProviderCategory;
  final String? role;
  final bool? isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserBaseProfileModel({
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.id,
    this.name,
    this.email,
    this.phone,
    required this.businessName,
    required this.businessRegistration,
    this.serviceProviderCategory,
    this.role,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserBaseProfileModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] ?? {};
    return UserBaseProfileModel(
      firstName: profile['firstName'] ?? json['firstName'] ?? '',
      lastName: profile['lastName'] ?? json['lastName'] ?? '',
      avatar: profile['avatar'] ?? json['avatar'] ?? '',
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      businessName: json['businessName'] ?? '',
      businessRegistration: json['businessRegistration'] ?? '',
      serviceProviderCategory: json['serviceProviderCategory'],
      role: json['role'],
      isVerified: json['isVerified'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'businessName': businessName,
      'businessRegistration': businessRegistration,
      'serviceProviderCategory': serviceProviderCategory,
      'role': role,
      'isVerified': isVerified,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'v': v,
    };
  }

  UserBaseProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? avatar,
    String? id,
    String? name,
    String? businessName,
    String? businessRegistration,
    String? serviceProviderCategory,
    String? role,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? email,
    String? phone,
  }) {
    return UserBaseProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
      name: name ?? this.name,
      businessName: businessName ?? this.businessName,
      businessRegistration: businessRegistration ?? this.businessRegistration,
      serviceProviderCategory: serviceProviderCategory ?? this.serviceProviderCategory,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
