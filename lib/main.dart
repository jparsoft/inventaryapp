import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:inventary_app/features/administration/presentation/pages/add_products_page.dart';
import 'package:inventary_app/features/home/presentation/pages/home_page.dart';

import 'features/administration/presentation/pages/manager_page.dart';
import 'features/g_sheet_api/data/datasources/g_sheet_api.dart';
import 'features/search/presentation/pages/search_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inventary App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final pages = [
    const SearchPage(),
    const AddProductsPage(),
    const HomePage(),
    const ManagerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back_image.jpeg"),
              fit: BoxFit.cover,
              opacity: .2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.search),
            label: 'Buscar',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add),
            label: 'Agregar',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.paste_rounded),
            label: 'Todos',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.app_settings_alt_rounded),
            label: 'Administrar',
          ),
        ],
      ),
    );
  }
}
