class ProfileModel {
  final String name;
  final String phone;
  final String email;
  final String location;
  final String imageUrl;
  final int orderCount;

  ProfileModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.imageUrl,
    required this.orderCount,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] ?? 'Zesty Go',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      location: map['location'] ?? '',
      imageUrl:
          map['imageUrl'] ?? '',
      orderCount: map['orderCount'] ?? 0,
    );
  }
}
