import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final List<String> currencies;
  final Function(String) onChanged;

  const CurrencyDropdown({
    super.key,
    required this.selectedCurrency,
    required this.currencies,
    required this.onChanged,
  });

  String getFlag(String currency) {
    switch (currency) {
      case "USD":
        return "🇺🇸";
      case "EUR":
        return "🇪🇺";
      case "GBP":
        return "🇬🇧";
      case "JPY":
        return "🇯🇵";
      default:
        return "❓";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCurrency,
          dropdownColor: Colors.grey[850],
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
          style: const TextStyle(fontSize: 16, color: Colors.white),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: currencies.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Text(getFlag(value), style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
