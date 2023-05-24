import 'dart:convert';

import 'package:gsheets/gsheets.dart';
import 'package:inventary_app/core/app_logger.dart';
import 'package:inventary_app/features/g_sheet_api/data/models/product_fields.dart';
import 'package:inventary_app/features/g_sheet_api/data/models/product_model.dart';

class SheetsApi {
  static const _spreadSheetId = '1_zPcXUTgSlbNZjFxFSudI1WbG3hLVApjgD499zKD_yk';
  static const credentiaslsPath = 'credentials.json';
  static Worksheet? _productsSheet;
  static const _TAG = 'SheetsApi';

  static const sheetName = 'Products';
  static const sheetRange = 'A1:Z1000';

  static Future<GSheets> _loadCredentials() async {
    const contents = r'''{
    "type": "service_account",
    "project_id": "inventary-app-387301",
    "private_key_id": "b79cabaa58511ae49f35700e093637e7eb3ec6f7",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCaXaweoU7EmfXT\nUr6Iz+jpG8pHibcljEZOoa6eWgq9baWrOf05E/CeFSJnalNmlpQYllbAdUU+BwzM\nKPknAIi4mrRN6RWYs0yQYcBLRO90JPHBNFLATGhmyTRmtBtaMCNfssISVPQNX9pS\noVD40yfxagfAzcwE6mx377v1fVuWqGLkudP3gjSwFNX78N3vSJLYenEWte3SIKxW\n/yBF4NRcKFoxoJQxWasv7/ltJHKq4O7L0wzdDYsxC6v4k2f3uWdxWTGD23vSHgpF\nIgqPE5jUqqL3BykrA3s91qdvKc/te0ym77rTQBc2Lw7UpDV5QHfZVcL6YXio3/Rc\nO+bfOyLbAgMBAAECggEABVSMt/YL+T/zvBtUVvcO7NW302aO+23vk5GDrRYg3s+l\nc9cpxknI+jxylq2WOamjbYHrdvPVs0GdEIOtrsoW7oDxDuuogkBWuXmWoUK9Hf6U\nln5PCTLaPApgk9dORnv5DLnod6eVUczohgfp+t2XuH9XyzGQBO9vVWjizaRJgFc8\nbd5aD7FdIFlMdYWtirUZlFqnN6SuP6JMJOZh+8rdAXM+BMeYtdNHKl2VNhAj2NIl\n98B49/5gvC9mufagk/MXIqpzCInPPKd3kEFQESeaaAdCNa3KFxPWRP4UKMfb7/J+\noKpnELCm115hwXcEt9qlHWIgEB1gDyg03yUiQD8A6QKBgQDOf8iXwgrp6gktuhpz\nUX1AJls1/ktX4XDWXb/sL7hseaoY1L7E5KEbygczvwdniVDYw97+KAY/obUBxR9H\nxDDLk05tK0Vckesbd767FXjKmqPql4xFGgJPGnQ4JfBPtL0m850oh/ipCwnckv4N\nCtEEIm1xGd15dxOWOVJVYXJfjwKBgQC/XqHUeAxMDO0irYQq/zwTS3322RQO1Zai\nXd4n9mMj3JUqn1RZYGfnVfy63Dp3SEB4ddw4SLq9o3WOyJ/X9nvt6PLuivHHMA5B\nhwnn6dx3nYATVPWoICvk46f9KN53wl2zUFXh7EloDrnT0KnezU4ycEp2DLKVlua4\n73C0+Cfh9QKBgQCftjVvKqVGRbzToRzUFDLLat8g441iavra0aefBUmenHryuZjS\nsAHrfFYVr6oKaiodfWD7MfmjPW7B77RBzXvv9/6wcMc00acFl5ftGq5SBUjCKHRU\n/cjLZap9wtoay6+AcOscbg3ksKTv9MCJVdRTXk1HLLofN/nuNmd3oebUAQKBgQC0\nlUUarOnVvgDrz1dAB7gV8Q/9pxzhXrYVo4Rmq38kMRvlq5I6ANorl520ausU8m47\n/eQAjMkC+MOPKEyFy4domoDbjuvWbceWGCrF2I39pfdcxrhFnY4uIJG+OBmuYxBu\njClu1rzyX6sFcQtLPutCd2oceaDvvgUckH4Hl4BzHQKBgEFDTJXqWzQ+NVNAFHpk\ngm5raRwVZGx019vJnSHIMgn0wryj98sO+l3UTyRUqNBfBBzMA2gGmxNXpCVX53MB\nWzuXi6BjlLv3YjdKzhZwBYhAZ9j2dgLVhhn9OJSMMDyfIieXudi8cQy51v4NsDXJ\nAi0tIE6p4DlbR8Cmo6VpLvL0\n-----END PRIVATE KEY-----\n",
    "client_email": "inventary-service-acc@inventary-app-387301.iam.gserviceaccount.com",
    "client_id": "113930742997375571647",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/inventary-service-acc%40inventary-app-387301.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
}''';
    final json = jsonDecode(contents);
    return GSheets(json);
  }

  static Future init() async {
    try {
      final sheets = await _loadCredentials();
      const firstRow = ProductFields.values;
      final spreadsheet = await sheets.spreadsheet(_spreadSheetId);
      _productsSheet = await _getWorksheet(spreadsheet: spreadsheet);

      await _productsSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      AppLogger.log(_TAG, e.toString());
    }
  }

  static Future<Worksheet> _getWorksheet(
      {required Spreadsheet spreadsheet}) async {
    try {
      return await spreadsheet.addWorksheet(sheetName);
    } catch (e) {
      return spreadsheet.worksheetByTitle(sheetName)!;
    }
  }

  static Future<int> _getRowCount() async {
    if (_productsSheet == null) {
      return 0;
    }
    final lastRow = await _productsSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future insertRow(ProductModel row) async {
    try {
      final int rowCount = await _getRowCount();
      final newRow = row.copyWith(id: '${rowCount + 1}');

      AppLogger.log(_TAG, 'Inserting row: ${newRow.toJson()}');

      await _productsSheet!.values.map.appendRow(newRow.toJson());
    } catch (e) {
      AppLogger.log(_TAG, e.toString());
    }
  }

  static Future<List<ProductModel>> getProducts() async {
    try {
      final products = await _productsSheet!.values.map.allRows();
      AppLogger.log(_TAG, 'Products: $products');
      return products!.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      AppLogger.log(_TAG, e.toString());
      return [];
    }
  }

  static Future<List<ProductModel>> getProductsFiltered(
      {required String filter}) async {
    try {
      final products = await _productsSheet!.values.map.allRows();
      AppLogger.log(_TAG, 'Products: $products');
      return products!
          .map((e) => ProductModel.fromJson(e))
          .where((element) => element.name.contains(filter)||element.category.contains(filter))
          .toList();
    } catch (e) {
      AppLogger.log(_TAG, e.toString());
      return [];
    }
  }

  // get by name
  static Future<ProductModel?> getByName({required String name}) async {
    try {
      final product =
          await _productsSheet!.values.map.rowByKey(name, fromColumn: 1);
      AppLogger.log(_TAG, 'Products: $product');
      return ProductModel.fromJson(product!);
    } catch (e) {
      AppLogger.log(_TAG, 'Producto no encontrado');
      return null;
    }
  }
}
