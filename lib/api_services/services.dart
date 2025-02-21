import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_1/model/news_model.dart';
import 'package:intl/intl.dart';


class ApiServices{
  int page = 1;
  String formattedDate = DateFormat('yyyy-mm-dd').format(DateTime.now());

  String get url{
    String apiKey = 'c6e6643ad9a94ff3a63db892a50ab703';
    return 'https://newsapi.org/v2/everything?q=tesla&from=formattedDate&sortBy=publishedAt&apiKey=$apiKey&pageSize=10&page=';
  }

  List<NewsModel> listOfNews = [];

  Future<List<NewsModel>> getData({required int page})async{
    try{
      final response = await http.get(Uri.parse(url+'$page'));
      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        final List jsonData = json['articles'];
        return listOfNews = jsonData.map<NewsModel>((e){
          return NewsModel(
              title: e['title'],
              description: e['description'],
              image: e['urlToImage'],
              publishedAt: e['publishedAt']);
        }).toList();
      }else{
        print('Unable to fetch data, check your status code ${response.statusCode}');
      }
    }catch(e){
      print('Error $e');
    }
    throw Exception();
  }
}

