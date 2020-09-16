import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:map_news/models/news.dart';
import 'package:map_news/components/widget.dart';

var lock = false;

Future<List<News>> getCategory(String category) async {
  if (lock) {
    return [];
  }
  var list = List<News>();
  var response = await http.get(
      'https://newsapi.org/v2/top-headlines?category=${category}&pageSize=10&country=in&apiKey=16d1ef027190474ebd9f2bd76ddabc8b');
  if (response.statusCode == 200) {
    jsonDecode(response.body)['articles']
        .forEach((e) => list.add(News.fromJson(e)));
    print(list);
  }
  return list;
}

class NewsScreen extends StatefulWidget {
  final location;

  NewsScreen({this.location});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final api_key = 'c3331ea850994b449943e957ef2e6f05';
  bool newsloaded;
  var business;
  var entertainment;
  var general;
  var health;
  var science;
  var sports;
  var technology;
  var finalList;
  var category = [
    "General",
    "Entertainment",
    "Business",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];

  getLists() async {
     business = await getCategory("business");
     entertainment = await getCategory("entertainment");
     general = await getCategory("general");
     health = await getCategory("health");
     science = await getCategory("science");
     sports = await getCategory("sports");
     technology = await getCategory("technology");

    if (lock) {
      return 0;
    }
    setState(() {
      finalList = [
        general,
        entertainment,
        business,
        health,
        science,
        sports,
        technology
      ];
      newsloaded = true;
    });
  }

  @override
  void initState() {
    lock = false;
    newsloaded = false;
    getLists();
    super.initState();
  }

  @override
  void dispose() {
    lock = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: !(newsloaded)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Swiper(
                itemCount: finalList.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewsTile(
                    newsList: finalList[index],
                    category: category[index],
                  );
                },
                control: SwiperControl(),
                pagination: SwiperPagination(),
                viewportFraction: 0.80,
                scale: 0.9,
              ));
  }
}
