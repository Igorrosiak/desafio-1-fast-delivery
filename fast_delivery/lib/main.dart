
import 'package:flutter/material.dart';
import 'src/routes/app_routes.dart';
import 'src/shared/storage/storage_config.dart';
import 'src/modules/initial/page/initial_page.dart';
import 'src/home/page/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageConfig.initHive(); // Inicializa o Hive
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      initialRoute: '/initial',
      routes: {
        '/initial': (context) => InitialPage(),
        '/': (context) => HomePage(),
      },
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(),
    );
  }
}
