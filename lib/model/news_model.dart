import 'package:hive_ce/hive.dart';

class NewsModel {
  String? title;
  String? description;
  String? image;
  String? publishedAt;

  NewsModel({
    required this.title,
    required this.description,
    required this.image,
    required this.publishedAt
  });


  factory NewsModel.fromJson(Map<String,dynamic> json){
    return NewsModel(
    title: json['title'] ?? 'No Title',
    description: json['description'] ?? 'No description',
        image: json['urlToImage'] ?? 'https://via.placeholder.com/150',
    publishedAt: json['publishedAt'] ?? '');
}

Map<String, dynamic> toMap(){
    return {
      'title': title,
      'description': description,
      'image': image,
      'publishedAt': publishedAt
    };
}

factory NewsModel.fromMap(Map<String, dynamic> map){
    return NewsModel(title: map['title'],
        description: map['description'],
        image: map['image'],
        publishedAt: map['publishedAt']);
}

}

