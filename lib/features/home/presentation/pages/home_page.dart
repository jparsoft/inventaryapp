import 'package:flutter/material.dart';

import '../../../g_sheet_api/data/datasources/g_sheet_api.dart';
import '../../../g_sheet_api/data/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];

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
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Bienvenido wekereke',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Mis productos'),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey[200],
                  child: ExpansionTile(
                    title: Text(products[index].name),
                    subtitle: Text('\$${products[index].price}'),
                    childrenPadding: const EdgeInsets.all(16),
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          const Text('Cantidad'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(products[index].quantity),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Categoría'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(products[index].category),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Fecha de creación'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(products[index].createdAt),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Descripción'),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(products[index].description),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
