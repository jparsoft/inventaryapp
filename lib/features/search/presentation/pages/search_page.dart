import 'package:flutter/material.dart';
import 'package:inventary_app/features/g_sheet_api/data/datasources/g_sheet_api.dart';

import '../../../g_sheet_api/data/models/product_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductModel> products = [];
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //formulario de consulta de productos

            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre del producto',
                suffixIcon: Icon(Icons.search),
              ),
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      products.clear();
                      products = await SheetsApi.getProductsFiltered(
                          filter: searchController.text);
                      setState(() {});
                    },
                    child: const Text('Buscar'))),
            const SizedBox(
              height: 20,
            ),
            products.isEmpty?const Text(
              'Ingrese un producto para buscar',
              style: TextStyle(fontSize: 14),
            ):
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => ListTile(
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
            )
          ],
        ),
      ),
    );
  }
}
