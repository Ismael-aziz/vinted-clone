// votre_projet_flutter/lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000//api/";

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final String apiUrl = baseUrl + "login/";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
