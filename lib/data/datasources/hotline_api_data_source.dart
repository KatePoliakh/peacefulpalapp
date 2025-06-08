import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hotline.dart';

class HotlineApiDataSource {
  Future<Hotline?> fetchHotlineByCountry(String countryCode) async {
    final url =
        'https://emergencynumberapi.com/api/country/$countryCode?mobile=false';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return Hotline.fromApi(result);
    }
    return null;
  }
}
