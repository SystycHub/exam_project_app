import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency_provider.dart';
import '../widgets/currency_dropdown.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          'Currency Exchange',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 0.7,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[850],
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown-container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Select Currencies:",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CurrencyDropdown(
                        selectedCurrency: currencyProvider.fromCurrency,
                        currencies: ["USD", "EUR", "GBP", "JPY"],
                        onChanged: (value) {
                          currencyProvider.setFromCurrency(value);
                        },
                      ),
                      const SizedBox(width: 10),
                      // SWAP BUTTON 🔄
                      IconButton(
                        icon: const Icon(Icons.swap_horiz, color: Colors.tealAccent, size: 28),
                        onPressed: () {
                          String temp = currencyProvider.fromCurrency;
                          currencyProvider.setFromCurrency(currencyProvider.toCurrency);
                          currencyProvider.setToCurrency(temp);
                        },
                      ),
                      const SizedBox(width: 10),
                      CurrencyDropdown(
                        selectedCurrency: currencyProvider.toCurrency,
                        currencies: ["USD", "EUR", "GBP", "JPY"],
                        onChanged: (value) {
                          currencyProvider.setToCurrency(value);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

              GestureDetector(
              onTapDown: (_) {
                currencyProvider.fetchExchangeRate();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.teal[400],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 8, spreadRadius: 2),
                  ],
                ),
                child: const Text(
                  "Get Exchange Rate",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

                        currencyProvider.isLoading
                ? const CircularProgressIndicator(color: Colors.tealAccent)
                : currencyProvider.currencyRate == null
                ? const Text("No data available", style: TextStyle(color: Colors.white70))
                : Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
                ],
              ),
              child: Text(
                "1 ${currencyProvider.currencyRate!.from} = ${currencyProvider.currencyRate!.rate.toStringAsFixed(4)} ${currencyProvider.currencyRate!.to}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
