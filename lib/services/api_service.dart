import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sawal_model.dart';

class ApiService {
  static const String apiUrl = 'https://dev.itinstruct.com/irshadat/fetch_irshadate.php';

  Future<List<SawalModel>> fetchSawals() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => SawalModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
