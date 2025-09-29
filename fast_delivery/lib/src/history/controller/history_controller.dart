import 'package:mobx/mobx.dart';
import '../../home/model/address_model.dart';
import '../../home/repositories/local_storage_repository.dart';
import 'package:hive/hive.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
	final LocalStorageRepository localStorageRepository;

	_HistoryControllerBase(this.localStorageRepository);

	@observable
	ObservableList<Address> addressHistory = ObservableList<Address>();

	@action
	void loadHistory() {
		addressHistory = ObservableList<Address>.of(localStorageRepository.getAddresses());
	}
}
