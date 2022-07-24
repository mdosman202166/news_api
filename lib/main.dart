import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/model/newsapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _Style =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

  List<Article> dataList = [];

  @override
  void initState() {
    getDataFormaApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("News pi")),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.black12, border: Border.all(color: Colors.black)),
            height: MediaQuery.of(context).size.height / 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("status"), Text("total result")],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 210,
            child: dataList.length==0?Center(
              child: CircularProgressIndicator(
              ),
            ):ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width - 20,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(8),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Stack(
                      children: [
                        Image.network(
                          dataList[index].urlToImage,
                          height: MediaQuery.of(context).size.height * .3,
                          width: MediaQuery.of(context).size.width - 20,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .3,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dataList[index].author,
                                    style: _Style,
                                  ),
                                  Text(
                                    dataList[index].publishedAt,
                                    style: _Style,
                                  )
                                ],
                              ),

                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.4)
                                ),
                                child: Text(
                                  textAlign: TextAlign.start,
                                  dataList[index].title,
                                  style: _Style,
                                  maxLines: 2,
                                ),
                              ),
                              // Text(
                              //   dataList[index].url,
                              //   style: _Style,
                              // ),
                              Text(
                                dataList[index].content,
                                style: _Style,
                                maxLines: 1,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.4)
                                ),
                                child: Text(
                                  dataList[index].description,
                                  style: _Style,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  getDataFormaApi() async {
    String apiurl =
        "https://newsapi.org/v2/everything?q=tesla&from=2022-06-22&sortBy=publishedAt&apiKey=430b205f05f34cae9f7323718b7b99c0";

    var rasult = await http.get(Uri.parse(apiurl));

    print(rasult.body);
    var jesonData = jsonDecode(rasult.body);
    print(jesonData);

    jesonData['articles'].forEach((item) {
      Article articles = Article(
        item['author'] ?? "Osman",
        item['title'] ?? "",
        item['description'] ?? "",
        item['url'] ?? "",
        item['urlToImage'] ?? "",
        item['publishedAt'] ?? "",
        item['content'] ?? "",
      );
      //abc
      // Article source = Article(
      //   item['source'] ?? "",
      //   item['author'] ?? "",
      //   item['title'] ?? "",
      //   item['description'] ?? "",
      //   item['url'] ?? "",
      //   item['urlToImage'] ?? "",
      //   item['publishedAt'] ?? "",
      //   item['content'] ?? "",
      // );

      // Source id = Source(
      //   item['id'] ?? "",
      //   item['name'] ?? "",
      // );

      dataList.add(articles);

      // dataListt.add(source);
      // dataListtt.add(id);
    });
    print(dataList);

    setState(() {});
  }
}
