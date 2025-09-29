import 'package:flutter/material.dart';

class EmptySearch extends StatelessWidget {
	const EmptySearch({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return const Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(Icons.search_off, size: 48, color: Colors.grey),
					SizedBox(height: 8),
					Text('Nenhum endereço encontrado.', style: TextStyle(fontSize: 16)),
				],
			),
		);
	}
}
