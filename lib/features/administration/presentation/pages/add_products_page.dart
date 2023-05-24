import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/progress_bar.dart';
import '../../../g_sheet_api/data/datasources/g_sheet_api.dart';
import '../../../g_sheet_api/data/models/product_model.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({super.key});

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  _insertProduct() async {
    generateLoader();
    await SheetsApi.insertRow(
      ProductModel(
        name: productNameController.text,
        price: productPriceController.text,
        category: productCategoryController.text,
      ),
    );
    Get.back();
    formClear();
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      await _insertProduct();
    }
  }

  formClear() {
    productNameController.clear();
    productCategoryController.clear();
    productPriceController.clear();
  }

  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();

  final productCategoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            //formulario
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: productNameController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre del producto',
              ),
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: productCategoryController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Categoría',
              ),
              validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
            ),

            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: productPriceController,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio publico',
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
                onPressed: _addProduct,
                child: const Text('Agregar producto'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
