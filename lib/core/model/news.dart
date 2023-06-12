class News {
  final Source source;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final String publishedAt;

  News({
    required this.source,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        source: Source.fromJson(json['source']),
        title: json['title'],
        description: json['description'],
        url: json['url'],
        publishedAt: json['publishedAt'],
        urlToImage: json['urlToImage']);
  }
}

class Source {
  final String name;

  Source({required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(name: json['name']);
  }
}
