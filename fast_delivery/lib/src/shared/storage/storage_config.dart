import 'package:fast_delivery/src/home/model/address_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageConfig {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AddressAdapter());
    await Hive.openBox<Address>('addressBox');
  }
}
