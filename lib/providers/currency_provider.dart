import 'package:flutter/material.dart';
import '../models/currency_rate.dart';
import '../services/api_service.dart';

class CurrencyProvider extends ChangeNotifier {
  CurrencyRate? _currencyRate;
  bool _isLoading = false;
  String _fromCurrency = "USD";
  String _toCurrency = "EUR";

  CurrencyRate? get currencyRate => _currencyRate;
  bool get isLoading => _isLoading;
  String get fromCurrency => _fromCurrency;
  String get toCurrency => _toCurrency;

  void setFromCurrency(String currency) {
    _fromCurrency = currency;
    notifyListeners();
  }

  void setToCurrency(String currency) {
    _toCurrency = currency;
    notifyListeners();
  }

  Future<void> fetchExchangeRate() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currencyRate = await ApiService.getExchangeRate(_fromCurrency, _toCurrency);
    } catch (e) {
      _currencyRate = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
