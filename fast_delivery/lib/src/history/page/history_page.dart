import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/history_controller.dart';
import '../../home/model/address_model.dart';
import '../../home/repositories/local_storage_repository.dart';
import '../../home/components/address_list.dart';
import 'package:hive/hive.dart';

class HistoryPage extends StatefulWidget {
	const HistoryPage({Key? key}) : super(key: key);

	@override
	State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
	late HistoryController controller;

	@override
	void initState() {
		super.initState();
		final addressBox = Hive.box<Address>('addressBox');
		controller = HistoryController(LocalStorageRepository(addressBox));
		controller.loadHistory();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Histórico de Endereços'),
				centerTitle: true,
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Observer(
					builder: (_) {
						if (controller.addressHistory.isEmpty) {
							return const Center(child: Text('Nenhum endereço consultado.'));
						}
						return AddressList(addresses: controller.addressHistory);
					},
				),
			),
		);
	}
}
