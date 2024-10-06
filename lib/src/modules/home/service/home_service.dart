import 'package:dio/dio.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/repositories/home_local_repository.dart';
import 'package:fast_location/src/modules/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';

class HomeService {
  final HomeRepository _repository = HomeRepository();
  final HomeLocalRepository _localRepository = HomeLocalRepository();

  Future<AddressModel> getAddress(String cep) async {
    try {
      Response response = await _repository.getAddressViaCep(cep);
      return AddressModel.fromJson(response.data);
    } catch (ex) {
      debugPrint('HomeService.getAddress -> ${ex.toString()}');
      rethrow;
    }
  }

  Future<List<AddressModel>> getAddressRecentList() async {
    try {
      final addressRecentList = await _localRepository.getAddressRecent();
      return addressRecentList ?? [];
    } catch (ex) {
      debugPrint('HomeService.getAddressRecentList -> ${ex.toString()}');
      rethrow;
    }
  }

  Future<void> updateAddressRecentList(AddressModel address) async {
    await _localRepository.addAddressRecent(address);
  }

  Future<List<AddressModel>> getAddressHistoryList() async {
    try {
      final addressHistoryList = await _localRepository.getAddressHistory();
      return addressHistoryList ?? [];
    } catch (ex) {
      debugPrint('HomeService.getAddressHistoryList -> ${ex.toString()}');
      rethrow;
    }
  }

  Future<void> incrementAddressHistoryList(AddressModel address) async {
    await _localRepository.addAddressHistory(address);
  }

  Future<void> openMap(BuildContext context, String address) async {
    try {
      final location = await getGeoLocation(address);

      final latitude = location?["latitude"] ?? 0;
      final longitude = location?["longitude"] ?? 0;

      final availableMaps = await MapLauncher.installedMaps;

      if (availableMaps.isNotEmpty) {
        await availableMaps.first.showDirections(
          destinationTitle: 'Destino',
          destination: Coords(latitude, longitude),
        );
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<Map<String, double>?> getGeoLocation(String address) async {
    final locations = await locationFromAddress(address);

    return {
      "latitude": locations.first.latitude,
      "longitude": locations.first.longitude,
    };
  }
}
