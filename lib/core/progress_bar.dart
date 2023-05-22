import 'package:flutter/material.dart';
import 'package:get/get.dart';

generateLoader() {
  Get.dialog(
    const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(),
      ),
    ),
    barrierDismissible: false,
  );
}
