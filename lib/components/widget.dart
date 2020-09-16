import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map_news/models/news.dart';

class NewsTile extends StatelessWidget {
  final newsList;
  final category;

  NewsTile({@required this.newsList, @required this.category});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(category.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            height: MediaQuery.of(context).size.height * 0.92,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: newsList.length,
              itemBuilder: (BuildContext context, int index) {
                News news = newsList[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: 290,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 120.0,
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  news.title ?? 'title yaha',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2.0),
                                // Text(
                                //   news.description ?? 'desc yaha',
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(
                                //       fontSize: 15.0,
                                //       fontWeight: FontWeight.w300),
                                // ),
                                // SizedBox(height: 2.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      size: 15.0,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      news.publishedAt,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.edit,
                                        size: 15.0,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        news.author == ''
                                            ? 'No Author Provided'
                                            : news.author.toString().substring(
                                                0,
                                                news.author.toString().length >
                                                        24
                                                    ? 24
                                                    : news.author
                                                            .toString()
                                                            .length -
                                                        1),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            height: 180.0,
                            width: MediaQuery.of(context).size.width * 0.70,
                            image: NetworkImage(news.urlToImage ??
                                'https://s3.cointelegraph.com/storage/uploads/view/39fecf448cb288e29a7c6de899c524d1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
