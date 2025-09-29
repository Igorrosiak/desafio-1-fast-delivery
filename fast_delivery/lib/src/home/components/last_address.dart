import 'package:flutter/material.dart';
import '../model/address_model.dart';

class LastAddress extends StatelessWidget {
	final Address? address;
	const LastAddress({Key? key, required this.address}) : super(key: key);

		@override
		Widget build(BuildContext context) {
			if (address == null) {
				return const Center(child: Text('Nenhum endereço consultado recentemente.'));
			}
			return Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					const Row(
						children: [
							Icon(Icons.location_on, color: Colors.green),
							Text(
								'Último Endereço localizado',
								style: TextStyle(
									fontSize: 16,
									fontWeight: FontWeight.bold,
									color: Colors.green,
								),
							),
						],
					),
					const SizedBox(height: 10),
					Card(
						margin: const EdgeInsets.all(8),
						child: ListTile(
							title: Text('${address!.logradouro}, ${address!.bairro}'),
							subtitle: Text('${address!.localidade} - ${address!.uf}'),
							trailing: Text(address!.cep),
						),
					),
				],
			);
		}
}
