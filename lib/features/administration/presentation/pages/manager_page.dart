import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/progress_bar.dart';
import '../../../g_sheet_api/data/datasources/g_sheet_api.dart';
import '../../../g_sheet_api/data/models/product_model.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  List<ProductResponse> products = [];
  final searchController = TextEditingController();

  search() async {
    setState(() {
      products.clear();
    });
    generateLoader();

    products =
        await SheetsApi.getProductsFiltered(filter: searchController.text);
    Get.back();
    setState(() {});
  }

  delete(id) async {
    generateLoader();
    await SheetsApi.deleteProduct(id: id);
    Get.back();
  }

  openEditDialog(ProductResponse product) {
    String name = product.name;
    String price = product.price;
    String category = product.category;
    Get.dialog(
      AlertDialog(
        title: const Text('Editar producto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: product.name,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre del producto',
              ),
              onChanged: null,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: product.category,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Categoria del producto',
              ),
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: product.price.toString(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio del producto',
              ),
              onChanged: (value) {
                setState(() {
                  price = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              generateLoader();
              product.name = name;
              product.price = price;
              product.category = category;
              await SheetsApi.updateProduct(product: product);
              Get.back();
              Get.back();
              search();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //formulario de consulta de productos
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Administrar productos',
                      style: TextStyle(fontSize: 20),
                    ),
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
                      validator: (value) =>
                          value!.isEmpty ? 'Campo requerido' : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () async {
                              search();
                            },
                            child: const Text('Buscar'))),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),

            products.isEmpty
                ? const Text(
                    'Ingrese un producto para editar',
                    style: TextStyle(fontSize: 14),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) => Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                              title: Text(
                                products[index].name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                              subtitle: Text(
                                '\$ ${products[index].price}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                              ),
                              leading: Card(
                                borderOnForeground: true,
                                shape: ShapeBorder.lerp(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  1,
                                ),
                                elevation: 5,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    openEditDialog(products[index]);
                                  },
                                ),
                              ),
                              trailing: Card(
                                borderOnForeground: true,
                                shape: ShapeBorder.lerp(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  1,
                                ),
                                elevation: 5,
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () async {
                                    await delete(products[index].id);
                                    setState(() {
                                      search();
                                    });
                                  },
                                ),
                              )),
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
