import '../model/address_model.dart';
import '../repositories/address_repository.dart';
import '../repositories/local_storage_repository.dart';

class HomeService {
	final AddressRepository addressRepository;
	final LocalStorageRepository localStorageRepository;

	HomeService({
		required this.addressRepository,
		required this.localStorageRepository,
	});

			Future<Address?> searchAddress(String cep) async {
				final address = await addressRepository.fetchAddressByCep(cep);
				// Verifica se o endereço é válido (logradouro, bairro, localidade e uf não podem ser vazios)
				final isValid = address != null &&
					address.logradouro.isNotEmpty &&
					address.bairro.isNotEmpty &&
					address.localidade.isNotEmpty &&
					address.uf.isNotEmpty;
				if (isValid) {
					await localStorageRepository.addAddress(address!);
					return address;
				}
				return null;
	}

	List<Address> getHistory() {
		return localStorageRepository.getAddresses();
	}

	Address? getLastAddress() {
		final history = getHistory();
		return history.isNotEmpty ? history.last : null;
	}
}
