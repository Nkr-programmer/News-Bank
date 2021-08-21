import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/provider/string.dart';
import 'package:news/screens/news_details/webiew.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> list = [];
  String text = "";
  int a = 0;

  getData(keyword) async {
    list = [];
    var url = Uri.parse(
        "https://ingnewsbank.com/api/get_news_by_keyword?skip=0&take=25&keyword=" +
            keyword);
    var res = await http.get(url);
    var jsonRes = jsonDecode("[" + res.body + "]");
    print(jsonRes);
    for (int i = 0; i < 50; i++) {
      try {
        list.add({
          
            "image": jsonRes[0]["news"][i]["main_image_thumb"],
          "title": jsonRes[0]["news"][i]["title"],
          "url": jsonRes[0]["news"][i]["imported_news_url"],
          "source": jsonRes[0]["news"][i]["source_website"],
          "time": jsonRes[0]["news"][i]["imported_date"]
        });
      } catch (e) {}
    }
    setState(() {
      a = 0;
    });
  }

  @override

  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var height = mq.height;
    var width = mq.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            backgroundColor: dark==0?Colors.blue[900]:Colors.black12,
            title: Text("समाचार खोजें",style: TextStyle(color:Colors.white,fontSize: 20),),
          ),
        ),
        backgroundColor: dark==0?Color(0xffF8F8F8):Colors.black,
        body: Column(
          children: [
             dark==0? Divider(thickness: 1,color:Colors.blue[900]):  Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: dark==0?Colors.blue:Colors.white),
                height: 50,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextField(
                              onChanged: (value) { 
                                 setState(() {
                                   text = value;
                                      a = 1;
                                    });
                                    getData(text);
                              },
                              onSubmitted: (data) {
                                setState(() {
                                  a = 1;
                                });
                                getData(data);
                              },
                              textInputAction: TextInputAction.search,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "शब्द टाइप करें"),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 2,
                            right: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2, right: 4),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: dark==0?Colors.white:Colors.black),
                                child: IconButton(
                                  icon: Icon(Icons.search,color:dark==0?Colors.black:Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      a = 1;
                                    });
                                    getData(text);
                                  },
                                ),
                              ),
                            ))
                      ],
                    )),
              ),
            ),
            a == 1
                ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircularProgressIndicator(),
                )
                : Expanded(
                    child: list.length > 0
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) => Card(
                                color: Colors.white,
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: 

Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 2),
                              child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebviewScreen(
                                                      newsTitle: list[index]
                                                          ['title'],
                                                      newsURL: list[index]
                                                          ['url'])));
                                    },
                                    title: Text(
                                    list[index]['title'].toString().length>68?
                                      list[index]['title'].toString().substring(0,68)+"..."
                                      :list[index]['title'].toString()
                                      ,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 1,
                                      ),
                                      child: Text(list[index]['source'].toString() +
                                          "    " +
                                          list[index]['time']),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(top: 34),
                                      child: InkWell(
                                          onTap: () {
                                            FlutterShare.share(
                                                title: "Title",
                                                text: list[index]['title'],
                                                chooserTitle:
                                                    "इस खबर को शेयर करो...");
                                          },
                                          child: Icon(Icons.share)),
                                    )),


                            )





                              ),
                            ),
                          )
                        : Text(
                            'No results found',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}

// GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   WebviewScreen(
//                                                       newsTitle: list[index]
//                                                           ['title'],
//                                                       newsURL: list[index]
//                                                           ['url'])));
//                                 },
//                                 child: Container(
//                                   height:80, 
//                                   //height * 0.10,
//                                   width: width,
//                                   decoration: BoxDecoration(
//                                       color: Colors.green[50],
//                                       borderRadius: BorderRadius.circular(5),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             offset: Offset(3, 3),
//                                             color: Colors.black12,
//                                             spreadRadius: 0.05)
//                                       ]),
//                                   child: Row(
//                                     children: [
//                                       list[index]["image"] ==
//                                               null
//                                           ? SizedBox()
//                                           : Container(
//                                               height: height * 0.18,
//                                               width: width * 0.4,
//                                               decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                       image: CachedNetworkImageProvider(
//                                                           list[index][
//                                                               "image"].toString()),
//                                                       fit: BoxFit.cover)),
//                                             ),
//                                       SizedBox(width: 2),
//                                       Expanded(
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 5),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               AutoSizeText(
//                                                list[index]['title'].toString().length>68?
//                                       list[index]['title'].toString().substring(0,68)+"..."
//                                       :list[index]['title'].toString(),
//                                                 style: TextStyle(
//                                                     fontWeight:
//                                                         FontWeight.bold), textScaleFactor: 1.0,
//                                                 maxLines: 3,
//                                                 minFontSize: 15,
//                                                 maxFontSize: 29,
//                                               ),
//                                               // heading(
//                                               //     text: homeNewsData[index]
//                                               //         ["news"][index2]["title"],
//                                               //     maxLines: 3,
//                                               //     scale: 1.25,
//                                               //     weight: FontWeight.w800,
//                                               //     align: TextAlign.left),

//                                               Flexible(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   children: [
//                                                     Expanded(
//                                                       child: new Container(
//                                                           padding:
//                                                               new EdgeInsets
//                                                                       .only(
//                                                                   right: 13.0),
//                                                           child: RichText( textScaleFactor: 1.0,
//                                                             overflow:
//                                                                 TextOverflow
//                                                                     .ellipsis,
//                                                             text: TextSpan(
//                                                               text: list[index]['source'].toString(),
//                                                               style: TextStyle(
//                                                                   fontSize: 11,
//                                                                   color: Colors
//                                                                       .black54),
//                                                               children: <
//                                                                   TextSpan>[
//                                                                 TextSpan(
//                                                                     text: ' | ',
//                                                                     style: TextStyle(
//                                                                         fontWeight:
//                                                                             FontWeight.bold)),
//                                                                 TextSpan(
//                                                                     text: list[index]['time']
//                                                                         .toString(),
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .blue))
//                                                               ],
//                                                             ),
//                                                           )),
//                                                     ),
//                                                     GestureDetector(
//                                                       onTap: () {
//                                                         FlutterShare.share(
//                                                 title: "Title",
//                                                 text: list[index]['title'],
//                                                 chooserTitle:
//                                                     "इस खबर को शेयर करो...");
//                                                       },
//                                                       child: Icon(
//                                                         Icons.share,
//                                                         size: height * 0.02,
//                                                         color: Colors.red,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),