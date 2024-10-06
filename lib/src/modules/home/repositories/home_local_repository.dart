import 'dart:convert';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:hive/hive.dart';

class HomeLocalRepository {
  final String boxAddressHistory = 'addressHistory';
  final String boxAddressRecent = 'addressRecent';
  late Box<String> addressBox;

  Future<void> addAddressHistory(AddressModel address) async {
    addressBox = await Hive.openBox(boxAddressHistory);

    List<AddressModel> addressList = await getAddressHistory() ?? [];

    addressList.add(address);

    final localAddressList = jsonEncode(addressList.reversed.toList());
    await addressBox.put(boxAddressHistory, localAddressList);
  }

  Future<void> addAddressRecent(AddressModel address) async {
    addressBox = await Hive.openBox(boxAddressRecent);

    List<AddressModel> addressList = await getAddressRecent() ?? [];

    if (addressList.length >= 3) {
      addressList.removeAt(0);
    }
    addressList.add(address);

    final localAddressList = jsonEncode(addressList.reversed.toList());
    await addressBox.put(boxAddressRecent, localAddressList);
  }

  Future<List<AddressModel>?> getAddressHistory() async {
    addressBox = await Hive.openBox(boxAddressHistory);
    final localData = addressBox.get(boxAddressHistory);

    if (localData != null) {
      List<dynamic> localList = jsonDecode(localData);
      List<AddressModel> addressList =
          localList.map((data) => AddressModel.fromJsonLocal(data)).toList();
      return addressList;
    } else {
      return null;
    }
  }

  Future<List<AddressModel>?> getAddressRecent() async {
    addressBox = await Hive.openBox(boxAddressRecent);
    final localData = addressBox.get(boxAddressRecent);

    if (localData != null) {
      List<dynamic> localList = jsonDecode(localData);
      List<AddressModel> addressList =
          localList.map((data) => AddressModel.fromJsonLocal(data)).toList();
      return addressList;
    } else {
      return null;
    }
  }
}
