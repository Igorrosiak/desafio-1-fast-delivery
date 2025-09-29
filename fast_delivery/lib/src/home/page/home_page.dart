import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/home_controller.dart';
import '../service/home_service.dart';
import '../repositories/address_repository.dart';
import '../repositories/local_storage_repository.dart';
import '../components/address_list.dart';
import '../components/last_address.dart';
import '../components/empty_search.dart';
import '../model/address_model.dart';
import 'package:hive/hive.dart';
import '../../history/page/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  final TextEditingController cepController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final addressBox = Hive.box<Address>('addressBox');
    controller = HomeController(
      HomeService(
        addressRepository: AddressRepository(),
        localStorageRepository: LocalStorageRepository(addressBox),
      ),
    );
    controller.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Location'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.navigation,
                        size: 60,
                        color: Colors.green,
                      ),
                      Text(
                        'Faça uma busca para localizar seu destino',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(color: Colors.white),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Localizar endereço',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      controller.errorMessage = '';
                    });
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        String error = '';
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return SingleChildScrollView(
                              controller: null,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                  left: 16,
                                  right: 16,
                                  top: 16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                                      child: TextFormField(
                                        controller: cepController,
                                        decoration: const InputDecoration(
                                          labelText: 'Digite o CEP',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    if (error.isNotEmpty)
                                      Text(
                                        error,
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 32.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          backgroundColor: Colors.green,
                                          textStyle:
                                              const TextStyle(color: Colors.white),
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                        ),
                                        child: const Text(
                                          'Localizar endereço',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          String cep = cepController.text.trim();
                                          if (cep.length != 8 || int.tryParse(cep) == null) {
                                            setState(() {
                                              error = 'Por favor, insira um CEP válido (8 dígitos).';
                                            });
                                            return;
                                          }
                                          await controller.searchAddress(cep);
                                          if (controller.errorMessage.isNotEmpty) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => ErrorPage(message: controller.errorMessage),
                                              ),
                                            );
                                            return;
                                          }
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.green),
                    Text(
                      'Últimos endereços localizados',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: controller.addressHistory.isEmpty
                      ? const EmptySearch()
                      : AddressList(addresses: controller.addressHistory),
                ),
                const SizedBox(height: 20),
                LastAddress(address: controller.lastAddress),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const HistoryPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(color: Colors.white),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Histórico de endereços',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () async {
          final address = controller.lastAddress;
          if (address == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nenhum endereço consultado para traçar rota.')),
            );
            return;
          }
          final destination =
              '${address.logradouro}, ${address.bairro}, ${address.localidade}, ${address.uf}';
          List<Location> locations = [];
          try {
            locations = await locationFromAddress(destination);
          } catch (e) {
            // Não encontrou coordenadas
          }
          if (locations.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Não foi possível encontrar a localização para traçar a rota.')),
            );
            return;
          }
          final availableMaps = await MapLauncher.installedMaps;
          if (availableMaps.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nenhum aplicativo de mapas disponível.')),
            );
            return;
          }
          final loc = locations.first;
          await availableMaps.first.showDirections(
            destination: Coords(loc.latitude, loc.longitude),
            destinationTitle: destination,
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.directions,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
      ),
    );
  }
}
class ErrorPage extends StatelessWidget {
  final String message;
  const ErrorPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    title: const Text('Erro'),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    ),
    ),
    body: Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 64),
        const SizedBox(height: 24),
        Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.red),
        textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Voltar'),
        ),
      ],
      ),
    ),
    ),
  );
  }
}
