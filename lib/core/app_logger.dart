import 'package:logger/logger.dart';

var fullLog = [];

class AppLogger {
  static final Logger _logger = Logger();

  static void log(String tag, String message) {
    _logger.d("$tag: $message");
    fullLog.add("$tag: $message");
  }

  static void logError(String tag, String message) {
    _logger.e("$tag: $message");
    fullLog.add("$tag: $message");
  }

  static void clearLog() {
    fullLog.clear();
  }
}
