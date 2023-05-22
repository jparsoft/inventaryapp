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
  ProductModel? product;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                    product =
                        await SheetsApi.getByName(name: searchController.text);
                    setState(() {});
                  },
                  child: const Text('Buscar'))),
          const SizedBox(
            height: 20,
          ),
          product != null
              ? SizedBox(
                  height: 500,
                  child: ExpansionTile(
                    title: Text(product!.name),
                    subtitle: Text('\$${product!.price}'),
                    childrenPadding: const EdgeInsets.all(16),
                    expandedAlignment: Alignment.centerLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const Text('Cantidad'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(product!.quantity),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Categoría'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(product!.category),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Fecha de creación'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(product!.createdAt),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Descripción'),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(product!.description),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text('Use el buscador para encontrar un producto'),
                ),
        ],
      ),
    );
  }
}
