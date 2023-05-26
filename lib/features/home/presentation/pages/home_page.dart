import 'package:flutter/material.dart';

import '../../../g_sheet_api/data/datasources/g_sheet_api.dart';
import '../../../g_sheet_api/data/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductResponse> products = [];

  fetchProducts() async {
    products = await SheetsApi.getProducts();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Listado de productos',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Scrollbar(
                  trackVisibility: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          products[index].name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                        subtitle: Text(
                          products[index].category,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        trailing: Text(
                          '\$${products[index].price}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Total de productos: ${products.length}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
