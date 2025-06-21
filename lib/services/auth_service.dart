import 'dart:convert';

import 'package:chat_keluarga/utils/global_util.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalKeys.url}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'] ?? "Login Failed";
      } else {
        return "Login Failed: ${response.body}";
      }
    } catch (e) {
      return "Login Failed: $e";
    }
  }

  static Future<String> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${GlobalKeys.url}/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['token'] ?? "Register Failed";
      } else {
        return "Register Failed: ${response.body}";
      }
    } catch (e) {
      return "Register Failed: $e";
    }
  }
}
