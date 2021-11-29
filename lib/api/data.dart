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

  get e => null;


// factory Data.fromJson(Map<String, dynamic> json) {
//   return Data(
//
//     id: json['data']['data']['id'],
//     storeName: json['data']['data']['store_name'],
//     firstName: json['data']['data']['first_name'],
//     lastName: json['data']['data']['last_name'],
//   );
// }
}
