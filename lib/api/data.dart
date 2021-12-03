import 'package:apicall/database/database_helper.dart';

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
        id: json[AppDatabase.colId] ?? "",
        storeName: json[AppDatabase.colStoreName] ?? "",
        firstName: json[AppDatabase.colFirstName] ?? "",
        lastName: json[AppDatabase.colLastName] ?? "",
        email: json[AppDatabase.colEmail] ?? "",
        social: json[AppDatabase.colSocial] ?? "",
        phoneNumber: json[AppDatabase.colPhoneNumber] ?? "",
        address: json[AppDatabase.colAddress] ?? "",
        banner: json[AppDatabase.colBanner] ?? "",
        bannerId: json[AppDatabase.colBannerId],
        shopUrl: json[AppDatabase.colShopUrl],
        categories: json[AppDatabase.colCategories],
      );
    }


  Map<String, dynamic> toJson() {
    return {
      AppDatabase.colId : id,
      AppDatabase.colStoreName : storeName,
      AppDatabase.colFirstName : firstName,
      AppDatabase.colLastName : lastName,
      AppDatabase.colEmail : email,
      AppDatabase.colSocial : social,
      AppDatabase.colPhoneNumber : phoneNumber,
      AppDatabase.colAddress: address,
      AppDatabase.colBanner : banner,
      AppDatabase.colBannerId : bannerId,
      AppDatabase.colShopUrl : shopUrl,
      AppDatabase.colCategories : categories,
    };
  }
}
