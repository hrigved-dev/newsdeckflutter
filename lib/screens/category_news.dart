import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/news.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/news_tile.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<NewsModel> news = List<NewsModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    news = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Row(
            children: [
              Text(
                "News",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              Text(
                "Deck",
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: news.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imageURL: news[index].urlToImage,
                                title: news[index].title,
                                description: news[index].description,
                                url: news[index].url,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
