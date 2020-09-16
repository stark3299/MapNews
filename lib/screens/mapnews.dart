import 'package:flutter/material.dart';
import 'package:map_news/components/widget.dart';
class MapNews extends StatefulWidget {
  final location;
  final newslist;
  MapNews({@required this.location, @required this.newslist});

  @override
  _MapNewsState createState() => _MapNewsState();
}

class _MapNewsState extends State<MapNews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NewsTile(newsList: widget.newslist, category: widget.location),
      ),
    );
  }
}
