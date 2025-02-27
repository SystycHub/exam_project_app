class CurrencyRate {
  final String from;
  final String to;
  final double rate;

  CurrencyRate({required this.from, required this.to, required this.rate});

  factory CurrencyRate.fromJson(Map<String, dynamic> json, String from, String to) {
    return CurrencyRate(
      from: from,
      to: to,
      rate: json["conversion_rate"] ?? 0.0,
    );
  }
}
