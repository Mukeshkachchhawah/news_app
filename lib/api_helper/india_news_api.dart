// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;


class IndiaNewApi {
  Future<dynamic> getApi({required String CAT}) async {

    // Uri mUrl = Uri.parse(
    //     "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=57b8ab5c139e447c876d48365cb79a88");
    var response = await http.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=$CAT&apiKey=57b8ab5c139e447c876d48365cb79a88"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    //  return JsonDataModal.fromJson(json);
    } else {
      return null;
    //  return JsonDataModal();
    }
  }
}
