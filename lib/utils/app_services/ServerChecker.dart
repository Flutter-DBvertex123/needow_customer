import 'dart:io';
import 'package:http/http.dart' as http;

class ServerHealthHelper {
  static const String _baseUrl = 'https://api.needdow.graphicsvolume.com/';

  /// Returns:
  /// false → server OK (200)
  /// true  → server issue (non-200 / error)
  static Future<bool> hasServerIssue() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        return false; // ✅ No server issue
      } else {
        return true; // ❌ Server issue
      }
    } on SocketException {
      return true; // ❌ No internet / DNS
    } on HttpException {
      return true; // ❌ HTTP error
    } on FormatException {
      return true; // ❌ Bad response
    } catch (_) {
      return true; // ❌ Unknown error
    }
  }
}
