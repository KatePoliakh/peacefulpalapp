class ZenQuote {
  final String quote;
  final String author;

  ZenQuote({required this.quote, required this.author});

  factory ZenQuote.fromApi(Map<String, dynamic> map) {
    return ZenQuote(
      quote: map['q'] ?? '',
      author: map['a'] ?? '',
    );
  }
}
