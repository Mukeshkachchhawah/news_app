


class Articles {
  String? author;
  String? content;
  String? description;
  String? publishedAt;
  Source? source;
  String? title;
  String? url;
  String? urlToImage;

  Articles(
      {this.author,
      this.content,
      this.description,
      this.publishedAt,
      this.source,
      this.title,
      this.url,
      this.urlToImage});

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
        author: json['author'],
        content: json['content'],
        description: json['description'],
        publishedAt: json['publishedAt'],
        source: Source.fromJson(json['source']),
        title: json['title'],
        url: json['url'],
        urlToImage: json['urlToImage']);
  }
}

class Source {
  String? id;
  String? name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }
}
