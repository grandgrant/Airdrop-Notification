import 'package:airdrop_notification/data/model/airdrop_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveUtils {
  static Future<void> initHive() {
    return Hive.initFlutter("authenticator");
  }

  static Future<Box<List>> getInstance(String name) async {
    bool isBoxExist = await Hive.boxExists(name);

    if (isBoxExist) {
      bool isOpen = Hive.isBoxOpen(name);
      if (isOpen) {
        return Hive.box<List>(name);
      } else {
        return Hive.openBox<List>(name);
      }
    } else {
      return Hive.openBox<List>(name);
    }
  }
}
