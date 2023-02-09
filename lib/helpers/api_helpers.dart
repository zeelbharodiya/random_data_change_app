
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;







import '../models/data_random.dart';

class APIHelper {
  // Singleton object
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();

  Future<RandomData?> fetchRates() async {
    // String city = "surat";
    // String apiKey = "LW73JB84Hvwg7cEacg7nLKca1BY2kqC9cRl7Y8Bb";
    // String api = "https://random-data-api.com/api/v2/users?size=5&is_xml=true";
    String api = "https://random-data-api.com/api/v2/users?size=1&is_xml=true";


    http.Response res = await http.get(Uri.parse(api));

    if(res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      //row data => customdata
      RandomData randomdata = RandomData.fromMap(data: decodedData );

      return randomdata;
    }
  }
}