import 'package:flutter/material.dart';
import 'package:map_news/screens/locationscreen.dart';
import 'package:map_news/models/news.dart';
import 'package:map_news/screens/newsscreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.poppins(),
          bodyText2: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var news = List<News>();

  int index = 0;

  var body = [NewsScreen(), LocationScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Container(child: body[index]),
        floatingActionButton: FloatingActionButton(
          child: index==0?Icon(Icons.map):Icon(Icons.receipt),
          onPressed: () {
            setState(() {
              index = index == 0 ? 1 : 0;
            });
          },
        ),
      ),
    );
  }
}
