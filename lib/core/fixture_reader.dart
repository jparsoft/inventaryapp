import 'dart:io';

class FixtureReader {
  static String fixture(String name) {
    return File('assets/$name').readAsStringSync();
  }
}
