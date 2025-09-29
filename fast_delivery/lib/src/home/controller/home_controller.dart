import 'package:mobx/mobx.dart';
import '../model/address_model.dart';
import '../service/home_service.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final HomeService homeService;

  _HomeControllerBase(this.homeService);

  @observable
  ObservableList<Address> addressHistory = ObservableList<Address>();

  @observable
  Address? lastAddress;

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @action
  Future<void> searchAddress(String cep) async {
    isLoading = true;
    errorMessage = '';
    try {
      final address = await homeService.searchAddress(cep);
      if (address != null) {
        lastAddress = address;
        addressHistory = ObservableList<Address>.of(homeService.getHistory());
      } else {
        errorMessage = 'CEP não encontrado.';
      }
    } catch (e) {
      errorMessage = 'Erro ao buscar endereço.';
    }
    isLoading = false;
  }

  @action
  void loadHistory() {
    addressHistory = ObservableList<Address>.of(homeService.getHistory());
    lastAddress = homeService.getLastAddress();
  }
}
