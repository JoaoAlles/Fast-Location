import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/home_service.dart';
import 'package:mobx/mobx.dart';

part 'history_controller.g.dart';

// ignore: library_private_types_in_public_api
class HistoryController = _HistoryController with _$HistoryController;

abstract class _HistoryController with Store {
  final HomeService _service = HomeService();

  @observable
  bool isLoading = false;

  @observable
  bool hasAddress = false;

  @observable
  ObservableList<AddressModel> addressHistoryList = ObservableList<AddressModel>.of([]);

  @action
  Future<void> loadData() async {
    isLoading = true;
    addressHistoryList.clear(); 
    addressHistoryList.addAll(await _service.getAddressHistoryList());
    hasAddress = addressHistoryList.isNotEmpty;
    isLoading = false;
  }
}
