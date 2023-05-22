import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

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
                  onPressed: () {}, child: const Text('Buscar'))),
        ],
      ),
    );
  }
}