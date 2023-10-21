import 'dart:convert';

import 'package:http/http.dart' as http;

class UsNewsApi {
  Future<dynamic> getUsNew() async{
    Uri mUrl = Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f739db37e41942fa97ee287a3f9d3f0f");
   var response = await http.get(mUrl);

   if (response.statusCode == 200) {
      return jsonDecode(response.body);
    //  return JsonDataModal.fromJson(json);
    } else {
      return null;
    //  return JsonDataModal();
    }
  }
}
