import 'package:flutter/material.dart';
import '../model/address_model.dart';

class AddressList extends StatelessWidget {
	final List<Address> addresses;
	const AddressList({Key? key, required this.addresses}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		if (addresses.isEmpty) {
			return const Center(child: Text('Nenhum endereço consultado.'));
		}
			final reversed = List<Address>.from(addresses.reversed);
			return ListView.builder(
				shrinkWrap: true,
				itemCount: reversed.length,
				itemBuilder: (context, index) {
					final address = reversed[index];
					return ListTile(
						title: Text('${address.logradouro}, ${address.bairro}'),
						subtitle: Text('${address.localidade} - ${address.uf}'),
						trailing: Text(address.cep),
					);
				},
			);
	}
}
