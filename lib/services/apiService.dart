import 'dart:convert';

import 'package:exchange/models/coinModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<CoinModel>> getPosts() async {
    try {
      var request = await http.get(
        Uri.parse('https://cbu.uz/ru/arkhiv-kursov-valyut/json/'),
      );
      if (request.statusCode >= 200 && request.statusCode < 300) {
        List<CoinModel> data = List<CoinModel>.from(
            json.decode(request.body).map((x) => CoinModel.fromJson(x)));
        return data;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
