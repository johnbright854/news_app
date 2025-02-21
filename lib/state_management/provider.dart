import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:project_1/api_services/services.dart';
import 'package:project_1/model/news_model.dart';
import 'package:hive_ce/hive.dart';

class NewsProvider extends ChangeNotifier{
  List<NewsModel> _listOfNews = [];
  List<NewsModel> _cachedNews = [];
  bool _isLoading = false;
  int _page = 1;
  get listOfNews => _listOfNews;
  get cachedNews => _cachedNews;
  bool get isLoading => _isLoading;
  bool _isConnectedToInternet = false;
  StreamSubscription? _internetStreamSubscription;

  late Box newsBox;

  get page => _page;

  bool get isConnectedToInternet => _isConnectedToInternet;

  NewsProvider(){
    monitorInternetStatus();
    _initializeHive();
  }

  Future<void> _initializeHive()async{
    newsBox = await Hive.openBox('newsCache');
    _loadCachedData();
  }

  void _loadCachedData(){
    final cachedData = newsBox.get('newsList') as List<dynamic>? ?? [];
    _cachedNews = cachedData.map<NewsModel>((e) {
      final Map<String, dynamic> newsMap = Map<String, dynamic>.from(e as Map);
      return NewsModel.fromMap(newsMap);
    }).toList();
    notifyListeners();

  }

  void monitorInternetStatus(){
    _internetStreamSubscription = InternetConnection().onStatusChange.listen((event){
        _isConnectedToInternet = (event == InternetStatus.connected);
        if (_isConnectedToInternet) {
          getDataFromApi();
        }
        notifyListeners();
    });
  }

  @override
  void dispose() {
    _internetStreamSubscription?.cancel();
    Hive.close();
    super.dispose();
  }


  void getDataFromApi()async{
      if(_isLoading) return;
      _isLoading = true;
      notifyListeners();

      try{
        List<NewsModel> newData = await ApiServices().getData(page: _page);
        _listOfNews.addAll(newData);
        newsBox.put('newsList', newData.map((news)=>news.toMap()).toList());
        _cachedNews = List.from(_listOfNews);
        notifyListeners();
      }catch(e){
        print('$e');
      }
      _isLoading = false;
      notifyListeners();
}
  void loadMoreData(){
    _page++;
   getDataFromApi();
  }
}