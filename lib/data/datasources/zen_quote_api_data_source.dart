import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/zen_quote.dart';

class ZenQuoteApiDataSource {
  Future<ZenQuote?> fetchQuote() async {
    final url = 'https://zenquotes.io/api/random';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      if (result.isNotEmpty) {
        return ZenQuote.fromApi(result[0]);
      }
    }
    return null;
  }
}
