import 'articles.dart';

class JsonDataModal {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  JsonDataModal(
      { this.status,
       this.articles,
       this.totalResults});


  factory JsonDataModal.fromJson(Map<String, dynamic> json) {
    
      List<Articles> mNews = [];

      for(Map<String, dynamic> eachData in json['articles']){
        mNews.add(Articles.fromJson(eachData));
      }
    return JsonDataModal(
        status: json['status'],
        articles: mNews,
        totalResults: json['totalResults']);
  }
}
