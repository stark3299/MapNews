import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:map_news/models/news.dart';
import 'package:http/http.dart' as http;
class NewsCache {
  static List<News> news = List<News>();
  static List <News> business = List<News>();
  static List <News> sports = List<News>();
  static List <News> health = List<News>();
  static List <News> science = List<News>();
  static List <News> technology = List<News>();
  static List <News> entertainment = List<News>();
  static List <News> general = List<News>();



  static getNews({@required String location}) async {
    var list = List<News>();
    var response = await http.get('https://newsapi.org/v2/everything?q=${location}&apiKey=${"16d1ef027190474ebd9f2bd76ddabc8b"}');
    if(response.statusCode == 200){
        jsonDecode(response.body)['articles'].forEach((e) => list.add(News.fromJson(e)));
        print(list);
    }
    news = list;
  }
}