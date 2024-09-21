import 'package:flutter/foundation.dart';
import 'package:news_app/services/global_methods.dart';
import 'package:reading_time/reading_time.dart';

class NewsModel with ChangeNotifier{
  String newsId;
  String sourceName;
  String authorName;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String dateToShow;
  String content;
  String readingTimeText;

  NewsModel({
    required this.newsId,
    required this.sourceName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.dateToShow,
    required this.content,
    required this.readingTimeText,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    String title = json["title"] ?? "No Title Available";
    String content = json["content"] ?? "No Content Available";
    String description = json["description"] ?? "No Description Available";
    String dateToShow ="";
    // GlobalMethods.formattedDateText(json["publishedAt"]); 
    if( json["publishedAt"] != null){
      dateToShow = GlobalMethods.formattedDateText(json["publishedAt"]);
    }
    return NewsModel(
      newsId: json["source"]?["id"] ?? "", // Safely access nested fields
      sourceName: json["source"]?["name"] ?? "",
      authorName: json["author"] ?? "Unknown Author",
      title: title,
      description: description, 
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "https://techcrunch.com/wp-content/uploads/2022/01/locket-app.jpg?w=1390&crop=1", // Provide a default image URL
      publishedAt: json["publishedAt"] ?? "",
      dateToShow: dateToShow, // Placeholder; calculate this in your app logic
      content: content,
      readingTimeText: readingTime(title + description + content).msg, // Placeholder; calculate this in your app logic
    );
  }

  static List<NewsModel> newsFromSnapshot(List<dynamic> snapshot) {
    return snapshot.map((data) {
      return NewsModel.fromJson(data);
    }).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'newsId': newsId,
      'sourceName': sourceName,
      'authorName': authorName,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'dateToShow': dateToShow,
      'content': content,
      'readingTimeText': readingTimeText,
    };
  }

  //   @override
  // String toString() {
  //   return "newsid : $newsId";
  // }



}
