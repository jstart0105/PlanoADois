import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _emailKey = 'last_email';

  // Salva o último e-mail logado
  static Future<void> saveLastEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  // Recupera o último e-mail logado
  static Future<String?> getLastEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
}