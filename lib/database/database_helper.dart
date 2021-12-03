import 'package:apicall/database/db.dart';
import 'package:sembast/sembast.dart';
import 'package:apicall/api/data.dart';

class AppDatabase {

  static String colId = "id";
  static String colStoreName = "store_name";
  static String colFirstName = "first_name";
  static String colLastName = "last_name";
  static String colEmail = "email";
  static String colSocial = "social";
  static String colPhoneNumber = "phone";
  static String colAddress = "address";
  static String colBanner = "banner";
  static String colBannerId = "banner_id";
  static String colShopUrl = "shop_url";
  static String colCategories = "categories";



  static const String folderName = "items";
  final _itemFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await DatabaseHelper.instance.database;

  Future insertItem(Data item) async {
    await _itemFolder.add(await _db, item.toJson());
    print('Student Inserted successfully !!');
  }

  Future updateItem(Data item) async {
    final finder = Finder(filter: Filter.byKey(item.id));
    await _itemFolder.update(await _db, item.toJson(), finder: finder);
  }

  Future delete(Data item) async {
    final finder = Finder(filter: Filter.byKey(item.id));
    await _itemFolder.delete(await _db, finder: finder);
  }

  Future<List<Data>> getAllItems() async {
    try {
      final List<RecordSnapshot<dynamic, dynamic>> recordSnapshot = await _itemFolder.find(await _db);
      // print(recordSnapshot.first.value);
      return recordSnapshot.map((snapshot) {
        final Data item = Data.fromJson(snapshot.value ?? {});
        return item;
      }).toList();
    } catch (e) {
      // TODO
      return [];
    }
  }
}
