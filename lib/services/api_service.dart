import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/currency_rate.dart';

class ApiService {
  static const String _apiKey = "7162fa2fd7df4136946c69f9";
  static const String _baseUrl = "https://v6.exchangerate-api.com/v6/";

  static Future<CurrencyRate> getExchangeRate(String from, String to) async {
    final url = Uri.parse("$_baseUrl$_apiKey/pair/$from/$to");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CurrencyRate.fromJson(data, from, to);
      } else {
        throw Exception("Failed to load exchange rate: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
