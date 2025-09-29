import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/address_model.dart';

class AddressRepository {
		Future<Address?> fetchAddressByCep(String cep) async {
			final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
			if (response.statusCode == 200) {
				final data = json.decode(response.body);
				if (data['erro'] != null && data['erro'] == true) {
					return null;
				}
				return Address.fromJson(data);
			}
			return null;
	}
}
