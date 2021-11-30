class Data {
  final int id;
  final String storeName;
  final String firstName;
  final String lastName;
  final String email;
  final String? social;
  final String? phoneNumber;
  final bool? showEmail;
  final String? address;

  // final String? location;
  final String? banner;
  final int? bannerId;
  final String? shopUrl;
  final String? categories;

  Data({
    required this.id,
    required this.storeName,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.social,
    this.phoneNumber,
    this.showEmail,
    this.address,
    // this.location,
    this.banner,
    this.bannerId,
    this.shopUrl,
    this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      storeName: json['storeName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      social: json['social'],
      phoneNumber: json['phone'],
      address: json['address'],
      banner: json['banner'],
      bannerId: json['banner_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "storeName": storeName,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "social": social,
      "phoneNumber": phoneNumber,
      "address": address,
      "banner": banner,
      "shopUrl": shopUrl,
      "categories": categories,
    };
  }
}