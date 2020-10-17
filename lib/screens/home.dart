import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/data.dart';
import 'package:news_app/data/news.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/category_tile.dart';
import 'package:news_app/widgets/news_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = List<CategoryModel>();
  List<NewsModel> news = List<NewsModel>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    news = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
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
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'search..',
                            ),
                          ),
                        ),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          /// Categories
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 70,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return CategoryTile(
                                      imageURL: categories[index].imageURL,
                                      categoryName:
                                          categories[index].categoryName);
                                }),
                          ),

                          SizedBox(
                            height: 20.0,
                          ),

                          /// News
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            height: MediaQuery.of(context).size.height / 1.5,
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
                  ),
                ],
              ),
      ),
    );
  }
}
