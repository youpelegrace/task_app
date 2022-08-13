import 'package:hive/hive.dart';

class HiveStorage {
  // Save Data to Hive Box
  static void saveDataToHive({
    required String key,
    required String value,
  }) async {
    var box = await Hive.openBox("storeBox");
    box.put(key, value);
  }

  // Get Data from Hive Box
  static Future<String?> getDataFromHive({required String key}) async {
    var box = await Hive.openBox("storeBox");
    return box.get(key);
  }

  // Delete Data from Hive Box
  static void deleteDataInHive({required String key}) async {
    var box = await Hive.openBox("storeBox");
    box.delete(key);
  }

  static Future<void> deleteAllDataInHive() async {
    var box = await Hive.openBox("storeBox");
    await box.clear();
  }
}
