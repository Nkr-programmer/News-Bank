import 'dart:convert';
import 'dart:io';
import 'package:news/provider/homePageIndex_provider.dart';
import 'package:news/provider/string.dart';
import 'package:news/screens/news_details/html_news.dart';
import 'package:news/screens/news_details/webiew.dart';
import 'package:news/widgets/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class TopNews extends StatefulWidget {
  TopNews(this.scrollController);
 final ScrollController scrollController;
  @override
  _TopNewsState createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> {
  // Map custom_Ad = {};
  // Map native_Ad = {};
  // bool adsAvailable = true;
// Future<dynamic> getAds() async {
//     var request = http.Request('GET', Uri.parse('https://ingnewsbank.com/api/get_custom_ad'));
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       var responseString = await response.stream.bytesToString();

//       print(responseString);
//     var  decode = jsonDecode(responseString);
//     getallads=decode;
//       print(getallads.length.toString());
// print("state");
//     } else {
      
//       var responseString = await response.stream.bytesToString();

//       print(responseString);
//     }
//   }

  var getallads;
 Future<dynamic> getAds() async {
    //Get from cache
    String fileName = 'getAdNews.json';
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("reading from cache");

      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      setState(() {
        getallads = res;
      });
    } else {
      print("reading from internet");
      final url = "https://ingnewsbank.com/api/get_custom_ad";
    
      final req = await http.get(Uri.parse(url));

      if (req.statusCode == 200) {
        final body = req.body;

        file.writeAsStringSync(body, flush: true, mode: FileMode.write);
        final res = jsonDecode(body);
        setState(() {
          getallads = res;
        });
      } else {
        setState(() {
          getallads = jsonDecode(req.body);
        });
      }
    }

    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        String fileName = 'getAdNews.json';
        var dir = await getTemporaryDirectory();

        File file = File(dir.path + "/" + fileName);
        print("reading from internet");
        final url = "https://ingnewsbank.com/api/get_custom_ad";
        final req = await http.get(Uri.parse(url));

        if (req.statusCode == 200) {
          final body = req.body;

          file.writeAsStringSync(body, flush: true, mode: FileMode.write);
          final res = jsonDecode(body);
          setState(() {
            getallads = res;
          });
        } else {
          setState(() {
            getallads = jsonDecode(req.body);
          });
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
//   Future<void> getAds() async {
//     //Get from cache
//     String fileName = 'custom_ad4.json';
//     var dir = await getTemporaryDirectory();

//     print(dir.path);
//     File file = File(dir.path + "/" + fileName);

//     if (file.existsSync()) {
//       print("reading from cache");
//       final data = file.readAsStringSync();
// //await response.stream.bytesToString();
//       // Map valueMap = json.decode(res);
//       print("lo" + data);
//       Map res = jsonDecode(data);
//       if (res["ads"].length == 0) {
//         setState(() {
//           adsAvailable = false;
//         });
//       } else {
//         print(res.runtimeType);
//         setState(() {
//           custom_Ad["img"] = res["ads"][0]["ad_banner"];
//           custom_Ad["link"] = res["ads"][0]["ad_link"];
//         });
//       }
//     } else {
//       print("reading from internet");
//       var request = http.Request(
//           'GET', Uri.parse('https://ingnewsbank.com/api/get_custom_ad'));

//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         var resp = await response.stream.bytesToString();
//         final body = jsonEncode(resp);

//         file.writeAsStringSync(body, flush: true, mode: FileMode.write);
//         var res = jsonDecode(resp);
//         if (!res["ads"].isEmpty) {
//           setState(() {
//             custom_Ad["img"] = res["ads"][0]["ad_banner"];
//             custom_Ad["link"] = res["ads"][0]["ad_link"];
//           });
//         } else {
//           setState(() {
//             adsAvailable = false;
//           });
//         }
//       } else {
//         setState(() {
//           adsAvailable = false;
//         });
//       }
//     }

//     try {
//       final result = await InternetAddress.lookup('www.google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         String fileName = 'custom_ad4.json';
//         var dir = await getTemporaryDirectory();

//         File file = File(dir.path + "/" + fileName);

//         print("reading from internet");
//         final url = "https://ingnewsbank.com/api/get_custom_ad";
//         final req = await http.get(Uri.parse(url));

//         if (req.statusCode == 200) {
//           final body = req.body;

//           Map res = jsonDecode(body);
//           file.writeAsStringSync(body.toString(),
//               flush: true, mode: FileMode.write);
//           if (res["ads"].isNotEmpty) {
//             setState(() {
//               custom_Ad["img"] = res["ads"][0]["ad_banner"];
//               custom_Ad["link"] = res["ads"][0]["ad_link"];
//             });
//           } else {
//             setState(() {
//               adsAvailable = false;
//             });
//           }
//         } else {
//           setState(() {
//             adsAvailable = false;
//           });
//         }
//       }
//     } on SocketException catch (_) {
//       print('not connected');
//       setState(() {
//         adsAvailable = false;
//       });
//     }

//     // var request = http.Request(
//     //     'GET', Uri.parse('https://ingnewsbank.com/api/get_custom_ad'));
//     //
//     // http.StreamedResponse response = await request.send();
//     //
//     // if (response.statusCode == 200) {
//     //   var res = jsonDecode(await response.stream.bytesToString());
//     //
//     //   setState(() {
//     //     custom_Ad["img"] = res["ads"][0]["ad_banner"];
//     //     custom_Ad["link"] = res["ads"][0]["ad_link"];
//     //   });
//     // } else {
//     //   print(response.reasonPhrase);
//     // }

//     //Get from cache
//     // String fileName1 = 'native_ad.json';
//     //
//     // File file1 = File(dir.path + "/" + fileName1);
//     //
//     // if (file1.existsSync()) {
//     //   print("reading from cache");
//     //   final data = jsonDecode(file.readAsStringSync());
//     //
//     //   setState(() {
//     //     native_Ad["img"] = data["ads"][0]["ad_banner"];
//     //     //
//     //     native_Ad["link"] = data["ads"][0]["ad_link"];
//     //   });
//     // } else {
//     //   print("reading from internet");
//     //   var request = http.Request(
//     //       'GET',
//     //       Uri.parse(
//     //           'https://ingnewsbank.com/api/get_ad_of_district?take=25&did=8&type=id'));
//     //
//     //   http.StreamedResponse response = await request.send();
//     //
//     //   if (response.statusCode == 200) {
//     //     var resp = await response.stream.bytesToString();
//     //     final body = jsonEncode(resp);
//     //
//     //     file1.writeAsStringSync(body, flush: true, mode: FileMode.write);
//     //
//     //     var res = jsonDecode(resp);
//     //
//     //     setState(() {
//     //       native_Ad["img"] = res["ads"][0]["ad_banner"];
//     //
//     //       native_Ad["link"] = res["ads"][0]["ad_link"];
//     //     });
//     //   } else {}
//     // }
//     //
//     // try {
//     //   final result = await InternetAddress.lookup('www.google.com');
//     //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//     //     String fileName = 'native_ad.json';
//     //     var dir = await getTemporaryDirectory();
//     //
//     //     File file = File(dir.path + "/" + fileName);
//     //
//     //     print("reading from internet");
//     //     final url =
//     //         "https://ingnewsbank.com/api/get_ad_of_district?take=25&did=8&type=id";
//     //     final req = await http.get(Uri.parse(url));
//     //
//     //     if (req.statusCode == 200) {
//     //       final body = req.body;
//     //
//     //       file.writeAsStringSync(body, flush: true, mode: FileMode.write);
//     //       Map res = jsonDecode(body);
//     //       setState(() {
//     //         native_Ad["img"] = res["ads"][0]["ad_banner"];
//     //
//     //         native_Ad["link"] = res["ads"][0]["ad_link"];
//     //       });
//     //     } else {}
//     //   }
//     // } on SocketException catch (_) {
//     //   print('not connected');
//     // }
//   }

  var homeNewsData;
  Future<void> getHomeNews() async {
    //Get from cache
    String fileName = 'getHomeNews.json';
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("reading from cache");

      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      setState(() {
        homeNewsData = res;
      });
    } else {
      print("reading from internet");
      final url = "https://ingnewsbank.com/api/home_latest_news?take=5&st_id=$hi";
    
      final req = await http.get(Uri.parse(url));

      if (req.statusCode == 200) {
        final body = req.body;

        file.writeAsStringSync(body, flush: true, mode: FileMode.write);
        final res = jsonDecode(body);
        setState(() {
          homeNewsData = res;
        });
      } else {
        setState(() {
          homeNewsData = jsonDecode(req.body);
        });
      }
    }

    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        String fileName = 'getHomeNews.json';
        var dir = await getTemporaryDirectory();

        File file = File(dir.path + "/" + fileName);
        print("reading from internet");
        final url = "https://ingnewsbank.com/api/home_latest_news?take=5&st_id=$hi";
        final req = await http.get(Uri.parse(url));

        if (req.statusCode == 200) {
          final body = req.body;

          file.writeAsStringSync(body, flush: true, mode: FileMode.write);
          final res = jsonDecode(body);
          setState(() {
            homeNewsData = res;
          });
        } else {
          setState(() {
            homeNewsData = jsonDecode(req.body);
          });
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
String hi="";
int done=0;
  Future<void> getInfo() async {
    getTopBarNewsData(); 
    getAds().then((value) {setState(() {
      done=1;
    });});
    
    getData().then((String value) {setState(() {
                    hi=value;
                   getHomeNews();
                  });} ); 
   
   
  }


  List<dynamic> topBarNewsData = [];
  String districtName = "";
  Future<void> getTopBarNewsData() async {
    String fileName = 'getTopBarNewsDataScrolling.json';
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("reading from cache");

      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      setState(() {
        topBarNewsData = res["news"]["data"];
        districtName = res["district"]["title"];
      });
    }
    // else {
    //   print("reading from internet");
    //   var request = http.Request(
    //       'GET',
    //       Uri.parse(
    //           'https://ingnewsbank.com/api/get_latest_news_by_district?page=1&did=8'));
    //
    //   http.StreamedResponse response = await request.send();
    //
    //   if (response.statusCode == 200) {
    //     final body = await response.stream.bytesToString();
    //
    //     file.writeAsStringSync(body, flush: true, mode: FileMode.write);
    //     final res = jsonDecode(body);
    //     setState(() {
    //       topBarNewsData = res["news"]["data"];
    //       districtName = res["district"]["title"];
    //     });
    //   } else {}
    // }

    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        String fileName = 'getTopBarNewsDataScrolling.json';
        var dir = await getTemporaryDirectory();

        File file = File(dir.path + "/" + fileName);
        print("reading from internet");
        final url =
            "https://ingnewsbank.com/api/get_latest_news_by_district?page=1&did=8";
        final req = await http.get(Uri.parse(url));

        if (req.statusCode == 200) {
          final body = req.body;

          file.writeAsStringSync(body, flush: true, mode: FileMode.write);
          final res = jsonDecode(body);
          setState(() {
            topBarNewsData = res["news"]["data"];
            districtName = res["district"]["title"];
          });
        } else {}
      }
    } on SocketException catch (_) {
      print('not connected');
    }

    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         'https://ingnewsbank.com/api/get_latest_news_by_district?page=1&did=8'));
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   var res = jsonDecode(await response.stream.bytesToString());
    //   print(res);
    //   setState(() {
    //     topBarNewsData = res["news"]["data"];
    //     districtName = res["district"]["title"];
    //   });
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  @override
  void initState() {
    super.initState();
getInfo(); 
  }
 changePage(int value) {
    Provider.of<HomePageIndexProvider>(context, listen: false)
        .changePage(value);
  }
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var height = mq.height;
    var width = mq.width;
ScrollController sc= new ScrollController();
    if (sc.hasClients)
      sc.animateTo(sc.position.maxScrollExtent,
          duration: Duration(milliseconds: 100000), curve: Curves.linear);
    return RefreshIndicator(
      onRefresh: () => getInfo(),
      child: ListView(
         controller: widget.scrollController,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Container(
            color: dark==0?Colors.lime[100]:Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: dark==0?Colors.black:Colors.white,size: height * 0.02),
                      heading(
                          text: districtName,
                          color: Colors.red,
                          scale: 1,
                          weight: FontWeight.w800)
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: heading(
                            text: "अपना शहर बदले",
                            color: dark==0?Colors.black:Colors.white,
                            scale: 1,
                            weight: FontWeight.w800),
                      ),
                      Icon(Icons.edit, color:dark==0?Colors.black:Colors.white, size: height * 0.02),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: height * 0.10,
                  color: dark==0?Colors.lime[100]:Colors.black,
            child: ListView.builder(
                controller: sc,
                scrollDirection: Axis.horizontal,
                itemCount: topBarNewsData.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 5),
                    child: Container(
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                topBarNewsData[index]["title"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textScaleFactor: 0.9,
                                minFontSize: 14,
                                style: TextStyle(color:dark==0?Colors.black:Colors.white,),
                              ),
                              // heading(
                              //     text: topBarNewsData[index]["title"],
                              //     align: TextAlign.left,
                              //     scale: 0.9),
                              SizedBox(height: 3),
                              Row(
                                children: [
                                  heading(
                                      text: topBarNewsData[index]
                                          ["source_website"],
                                      scale: 0.8,
                                      color: dark==0?Colors.black38:Colors.white54),
                                  heading(
                                    text: " | ",
                                    scale: 0.8,
color: dark==0?Colors.black38:Colors.white54
                                  ),
                                  heading(
                                      text: topBarNewsData[index]
                                          ["imported_date"],
                                      scale: 0.8,
                                      color: dark==0?Colors.blue:Colors.white70)
                                ],
                              )
                            ]),
                      ),
                    ),
                  );
                }),
          ),
          // adsAvailable
          //     ? Container(
          //         height: height * 0.1,
          //         width: width,
          //         child: custom_Ad["img"] == null
          //             ? Center(child: CircularProgressIndicator())
          //             : CachedNetworkImage(imageUrl: custom_Ad["img"] ?? ""),
          //       )
          //     : SizedBox(),
        //  child: getallads["ads"][0]["ad_banner"].toString().length==0
        //               ? Center(child: CircularProgressIndicator())
        //               : CachedNetworkImage(imageUrl:getallads["ads"][0]["ad_banner"]  ?? ""),
        //         )
      getallads==null?Container( height: height * 0.1,
                                                width: width ,): GestureDetector(
          onTap: () {
                                  if (getallads
                                                      ["ads"][0]
                                                    //  ["ad_banner"],
                                                    ["ad_link"].toString() !="null"){
                                        
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebviewScreen(
                                                  newsTitle: getallads
                                                      ["ads"][0]["title"],
                                                  newsURL: getallads
                                                      ["ads"][0]
                                                    //  ["ad_banner"],
                                                    ["ad_link"],
                                                )));}
                                   else {
                                  showDialog(context: context, builder: (context) =>
   new  AlertDialog(
   insetPadding:EdgeInsets.all(1),
   backgroundColor:Colors.black.withOpacity(0.0),
    actions: <Widget>[
      Container(width:MediaQuery.of(context).size.width,
      height:MediaQuery.of(context).size.height*0.85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
    Padding(
      padding: const EdgeInsets.only(left:25.0),
      child: GestureDetector(onTap: () =>
       Navigator.pop(context,true),child: Container(
         child:Icon(Icons.close,color:Colors.red),
       )),
    ),
                       SizedBox(width: 30,),
         Center(
           child: RotatedBox(
             quarterTurns: 3,
             child: ClipPath(
    child:       Image.network( getallads["ads"][0]["ad_banner"].toString(),fit: BoxFit.fill,)),),
         ),

           ],),
      ),
    ],
    )
    );
                                  
                                  
                                  
                                  
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => HTMLNews(
                                  //                 newsUrl: homeNewsData[index]
                                  //                         ["news"][index2]
                                  //                     ["imported_news_url"],
                                  //                 news_image:
                                  //                     homeNewsData[index]
                                  //                             ["news"][index2]
                                  //                         ["main_image"],
                                  //                 newsSource:
                                  //                     homeNewsData[index]
                                  //                             ["news"][index2]
                                  //                         ["source_website"],
                                  //                 newsTime: homeNewsData[index]
                                  //                         ["news"][index2]
                                  //                     ["imported_date"],
                                  //                 newsTitle: homeNewsData[index]
                                  //                     ["news"][index2]["title"],
                                  //                 htmlData: homeNewsData[index]
                                  //                     ["news"][index2]["body"],
                                  //               )));
                                   }
                                },

child: getallads["ads"][0]["ad_banner"]==
                                              null
                                          ? SizedBox()
                                          : Container(
                                               height: height * 0.1,
                                                width: width ,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                        getallads["ads"][0]["ad_banner"]),
                                                      fit: BoxFit.fill)),
                                            )
),
 
          SizedBox(height: 10),
          if (homeNewsData == null)
            Center(child: CircularProgressIndicator())
          else
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeNewsData.length,
                itemBuilder: (context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform(
                        transform: Matrix4.translationValues(0.0, 1, 0.0),
                        child: Container(
                            height: 5,
                            width: width,
                            color:  dark==0 ?hexColor(
                         homeNewsData[index]["category"]["bg_color_code"]
                                  .substring(1, 7),
                            ):Colors.white),
                      ),
                      Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 90),
                                        child: heading(
                                            text: homeNewsData[index]
                                                ["category"]["title"],
                                            color:dark==0 ?hexColor(homeNewsData[index]
                                                        ["category"]
                                                    ["text_color_code"]
                                                .substring(1, 7)):Colors.black,
                                            weight: FontWeight.w800,
                                            scale: 1.1),
                                      ),
                                    ),
                                    width: width * 0.5,
                                    height: 30,
                                    color: dark==0?hexColor(homeNewsData[index]
                                            ["category"]["bg_color_code"]
                                        .substring(1, 7)):Colors.white),
                                Transform(
                                  transform:
                                      Matrix4.translationValues(-1, 0, 0.0),
                                  child: Diagonal(
                                    child: Container(
                                      width: 50,
                                      height: 32,
                                      color: dark==0?hexColor(homeNewsData[index]
                                              ["category"]["bg_color_code"]
                                          .substring(1, 7)):Colors.white,
                                    ),
                                    clipHeight: 40,
                                    position: DiagonalPosition.BOTTOM_LEFT,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child:  GestureDetector(
                                onTap: (){
                                  
                                  changePage(index+1);
                                   },
                                child: heading(scale: 0.9,
                                    text: "और देखें",
                                    color: dark==0?Colors.blue[900]!:Colors.white,
                                    weight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeNewsData[index]["news"].length,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, int index2) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 2),
                              child: GestureDetector(
                                onTap: () {
                                  if (homeNewsData[index]["news"][index2]
                                          ["is_open_in_web_view"] ==
                                      0)
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WebviewScreen(
                                                  newsTitle: homeNewsData[index]
                                                      ["news"][index2]["title"],
                                                  newsURL: homeNewsData[index]
                                                          ["news"][index2]
                                                      ["imported_news_url"],
                                                )));
                                  else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HTMLNews(
                                                  newsUrl: homeNewsData[index]
                                                          ["news"][index2]
                                                      ["imported_news_url"],
                                                  news_image:
                                                      homeNewsData[index]
                                                              ["news"][index2]
                                                          ["main_image"],
                                                  newsSource:
                                                      homeNewsData[index]
                                                              ["news"][index2]
                                                          ["source_website"],
                                                  newsTime: homeNewsData[index]
                                                          ["news"][index2]
                                                      ["imported_date"],
                                                  newsTitle: homeNewsData[index]
                                                      ["news"][index2]["title"],
                                                  htmlData: homeNewsData[index]
                                                      ["news"][index2]["body"],
                                                )));
                                  }
                                },
                                child: Container(
                                  height:80, 
                                  //height * 0.10,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: dark==0? Colors.green[50]:Colors.white10,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(3, 3),
                                            color: Colors.black12,
                                            spreadRadius: 0.05)
                                      ]),
                                  child: Row(
                                    children: [
                                      homeNewsData[index]["news"][index2]
                                                  ["main_image_thumb"] ==
                                              null
                                          ? SizedBox()
                                          : Container(
                                              height: height * 0.18,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          homeNewsData[index]
                                                                      ["news"]
                                                                  [index2][
                                                              "main_image_thumb"]),
                                                      fit: BoxFit.cover)),
                                            ),
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                homeNewsData[index]["news"]
                                                    [index2]["title"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,color:dark==0?Colors.black:Colors.white,), textScaleFactor: 1.0,
                                                        
                                                maxLines: 3,
                                                minFontSize: 15,
                                                maxFontSize: 29,
                                              ),
                                              // heading(
                                              //     text: homeNewsData[index]
                                              //         ["news"][index2]["title"],
                                              //     maxLines: 3,
                                              //     scale: 1.25,
                                              //     weight: FontWeight.w800,
                                              //     align: TextAlign.left),

                                              Flexible(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: new Container(
                                                          padding:
                                                              new EdgeInsets
                                                                      .only(
                                                                  right: 13.0),
                                                          child: RichText( textScaleFactor: 1.0,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            text: TextSpan(
                                                              text: homeNewsData[
                                                                          index]
                                                                      [
                                                                      "news"][index2]
                                                                  [
                                                                  "source_website"],
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color:dark==0?Colors.black54:Colors.white,),
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text: ' | ',
                                                                    style: TextStyle(
                                                                      color:dark==0?Colors.black:Colors.white,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                                TextSpan(
                                                                    text: homeNewsData[index]["news"][index2]
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
                                                        FlutterShare.share(
                                                            title: "Title",
                                                            text: homeNewsData[index]["news"][index2]["title"],
                                                            chooserTitle:
                                                                "इस खबर को शेयर करो...");
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
                          }),
                    ],
                  );
                }),
        ],
      ),
    );
  }
}
