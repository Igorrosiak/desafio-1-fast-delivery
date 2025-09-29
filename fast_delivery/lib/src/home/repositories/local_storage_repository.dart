import 'package:hive/hive.dart';

import '../model/address_model.dart';

class LocalStorageRepository {
  final Box<Address> _addressBox;

  LocalStorageRepository(this._addressBox);

  Future<void> addAddress(Address address) async {
    await _addressBox.add(address);
  }

  List<Address> getAddresses() {
    return _addressBox.values.toList();
  }
}
