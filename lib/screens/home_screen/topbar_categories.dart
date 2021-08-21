import 'dart:convert';
import 'dart:io';

import 'package:news/provider/string.dart';
import 'package:news/screens/news_details/html_news.dart';
import 'package:news/screens/news_details/webiew.dart';
import 'package:news/widgets/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

class TopBarCategory extends StatefulWidget {
  int cpId;
  TopBarCategory(this.scrollController,{required this.cpId});
 final ScrollController scrollController;
  @override
  _TopBarCategoryState createState() => _TopBarCategoryState();
}

class _TopBarCategoryState extends State<TopBarCategory> {
  static int page = 1;
  PageController _controller = PageController(
    initialPage: 0,
  );
  //ScrollController _sc = new ScrollController();
  bool isLoading = false;
  int selectedIndex = 0;
  List catData = [];

  Future<dynamic> getData(int index) async {
    setState(() {
      index = 1;
      page = 1;
    });
    print("get data");
    String fileName = 'getTopBarCategoryData${widget.cpId.toString()}_13.json';
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("reading from cache");

      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      setState(() {
        catData.addAll(res);
      });
    }

    try {
      final result = await InternetAddress.lookup('www.google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("interet");
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });
          print(index);
          var request = http.Request(
              'GET',
              Uri.parse(
                  'https://ingnewsbank.com/api/home_top_bar_news_of_category?cp_id=${widget.cpId}&page=${index.toString()}'));

          http.StreamedResponse response = await request.send();
          if (response.statusCode == 200) {
            final body = await response.stream.bytesToString();

            final res = jsonDecode(body);
            setState(() {
              catData.clear();
              catData.addAll(res["data"]);
              print(index);
              print(catData);
              file.writeAsStringSync(jsonEncode(catData),
                  flush: true, mode: FileMode.write);

              isLoading = false;
              page++;
            });
          } else {}
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
        Toast.show("आपका इंटरनेट बंद है |", context);
      });
    }
  }

  Future<void> getMoreData(int index) async {
    print("get more data");
    String fileName = 'getTopBarCategoryData${widget.cpId.toString()}_13.json';
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
          });
          print(index);
          var request = http.Request(
              'GET',
              Uri.parse(
                  'https://ingnewsbank.com/api/home_top_bar_news_of_category?cp_id=${widget.cpId}&page=${index.toString()}'));

          http.StreamedResponse response = await request.send();
          if (response.statusCode == 200) {
            final body = await response.stream.bytesToString();

            final res = jsonDecode(body);

            setState(() {
              catData.addAll(res["data"]);
              file.writeAsStringSync(jsonEncode(catData),
                  flush: true, mode: FileMode.write);

              isLoading = false;
              page++;
            });
          } else {}
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
        
        Toast.show("आपका इंटरनेट बंद है |", context);
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.only(bottom: 55.0, top: 10),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getData(page).then((value) {setState(() {
      
    });});
    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.page!.toInt();
      });
    });
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels >
              widget.scrollController.position.maxScrollExtent / 1.100000000000000001 &&
          widget.scrollController.position.pixels <= widget.scrollController.position.maxScrollExtent) {
        getMoreData(page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var height = mq.height;
    var width = mq.width;
    return catData == null
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: catData.length + 1,
            controller: widget.scrollController,
            itemBuilder: (context, int index) {
              return index == catData.length
                  ? _buildProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          if (catData[index]["is_open_in_web_view"] == 0)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebviewScreen(
                                          newsTitle: catData[index]["title"],
                                          newsURL: catData[index]
                                              ["imported_news_url"],
                                        )));
                          else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HTMLNews(
                                          newsUrl: catData[index]
                                              ["imported_news_url"],
                                          news_image: catData[index]
                                              ["main_image"],
                                          newsSource: catData[index]
                                              ["source_website"],
                                          newsTime: catData[index]
                                              ["imported_date"],
                                          newsTitle: catData[index]["title"],
                                          htmlData: catData[index]["body"],
                                        )));
                          }
                        },
                        child: index == 0
                            ? Container(
                                decoration: BoxDecoration(
                                color:dark==0?Colors.green[50]:Colors.white10,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(3, 3),
                                          color: Colors.black12,
                                          spreadRadius: 0.05)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    children: [
                                      catData[index]["main_image_thumb"] == null
                                          ? SizedBox()
                                          : Container(
                                              height: height * 0.25,
                                              width: width,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          catData[index][
                                                              "main_image_thumb"]),
                                                      fit: BoxFit.cover)),
                                            ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top:8.0,left:8.0,right:8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              catData[index]["title"], 
                                             // widget.cpId.toString(),
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,color:dark==0?Colors.black:Colors.white,),
                                              maxLines: 2,
                                              minFontSize: 16,
                                              maxFontSize: 30,
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    heading(
                                                        text: catData[index]
                                                            ["source_website"],
                                                        scale: 0.9,color:dark==0?Colors.black54:Colors.white,
                                                        weight:
                                                            FontWeight.w300),
                                                    heading(text: " | ",color:dark==0?Colors.black54:Colors.white,),
                                                    heading(
                                                        text: catData[index]
                                                            ["imported_date"],
                                                        color: Colors.blue,
                                                        scale: 0.9)
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    FlutterShare.share(title: "Title",
                                                            text:
                                                                catData[index]
                                                                    ["title"],chooserTitle: "इस खबर को शेयर करो...");
                                                  },
                                                  child: Icon(
                                                    Icons.share,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: 80,
                                decoration: BoxDecoration(
                                   color:dark==0?Colors.green[50]:Colors.white10,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(3, 3),
                                          color: Colors.black12,
                                          spreadRadius: 0.05)
                                    ]),
                                child: Row(
                                  children: [
                                    catData[index]["main_image_thumb"] == null
                                        ? SizedBox()
                                        : Container(
                                       height: height * 0.18,
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                        catData[index][
                                                            "main_image_thumb"]),
                                                    fit: BoxFit.cover)),
                                          ),
                                           SizedBox(width: 2),
                                    Expanded(
                                      child: Padding(
                                         padding:  const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              catData[index]["title"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,color:dark==0?Colors.black:Colors.white,),
                                                  textScaleFactor: 1.0,
                                              maxLines: 3,
                                            minFontSize: 15,
                                                maxFontSize: 29,
                                            ),
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: new Container(
                                                        padding:
                                                            new EdgeInsets.only(
                                                                right: 13.0),
                                                        child: RichText(textScaleFactor: 1.0,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: catData[index]
                                                                [
                                                                "source_website"],
                                                            style: TextStyle(
                                                                fontSize: 11,color:dark==0?Colors.black54:Colors.white,),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                  text: ' | ',
                                                                  style: TextStyle(
                                                                    color:dark==0?Colors.black:Colors.white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              TextSpan(
                                                                  text: catData[
                                                                              index]
                                                                          [
                                                                          "imported_date"]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue))
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      {
                                                        //   Share.share(
                                                        //       catData[index]
                                                        //           ["title"],subject: "Hello");

                                                        FlutterShare.share(title: "Title",
                                                            text:
                                                                catData[index]
                                                                    ["title"],chooserTitle: "इस खबर को शेयर करो...");
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.share,
                                                      size: height * 0.02,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                    );
            });
  }
}