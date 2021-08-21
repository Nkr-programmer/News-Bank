import 'dart:convert';
import 'dart:io';

import 'package:news/provider/homePageIndex_provider.dart';
import 'package:news/provider/string.dart';
import 'package:news/screens/home_screen/Anaye_Rajye.dart';
import 'package:news/screens/home_screen/gallary.dart';
import 'package:news/screens/home_screen/news_gallery.dart';
import 'package:news/screens/home_screen/search_screen.dart';
import 'package:news/screens/home_screen/states_screen.dart';
import 'package:news/screens/home_screen/top_news.dart';
import 'package:news/screens/home_screen/topbar_categories.dart';
import 'package:news/screens/liveTV/liveTV_screen.dart';
import 'package:news/screens/news_details/html_news.dart';
import 'package:news/screens/news_details/webiew.dart';
import 'package:news/screens/radio/radio_screen.dart';
import 'package:news/widgets/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:news/provider/homePageIndex_provider.dart';
import 'package:news/screens/home_screen/search_screen.dart';
import 'package:news/screens/liveTV/liveTV_screen.dart';
import 'package:news/screens/radio/radio_screen.dart';
import 'package:news/widgets/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int topBarIndex = 0;
  int topWBarIndex =0;
  List<dynamic> topBarData = [];
  List<dynamic> topWBarData = [];

  var topbarCoontroller = new ScrollController();
   var arCoontroller = new ScrollController();
var wCoontroller = new ScrollController();
//var cCoontroller = new ScrollController();

  // Future<void> getTop(int x) async {
  //   String fileName = 'get${x}TopBarData.json';
  //   var dir = await getTemporaryDirectory();

  //   File file = File(dir.path + "/" + fileName);

  //   if (file.existsSync()) {
  //     print("reading from cache");

  //     final data = file.readAsStringSync();
  //     final res = jsonDecode(data);
  //     setState(() {
  //       topWBarData = res;
  //     });
  //   } else {
  //     print("reading from internet");
  //     var request = http.Request('GET',
  //         Uri.parse('https://ingnewsbank.com/api/home_top_bar_news_category?st_id=${x.toString()}'));

  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       final body = await response.stream.bytesToString();

  //       file.writeAsStringSync(body, flush: true, mode: FileMode.write);
  //       final res = jsonDecode(body);
  //       setState(() {
  //         topWBarData = res;
  //       });
  //     } else {}
  //   }

  //   try {
  //     final result = await InternetAddress.lookup('www.google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       print('connected');
  //       String fileName = 'get${x}TopBarData.json';
  //       var dir = await getTemporaryDirectory();

  //       File file = File(dir.path + "/" + fileName);
  //       print("reading from internet");
  //       //final url = "https://ingnewsbank.com/api/home_top_bar_news_category";
  //       final url = "https://ingnewsbank.com/api/home_top_bar_news_category?st_id=${x.toString()}";
  //       final req = await http.get(Uri.parse(url));

  //       if (req.statusCode == 200) {
  //         final body = req.body;

  //         file.writeAsStringSync(body, flush: true, mode: FileMode.write);
  //         final res = jsonDecode(body);
  //         setState(() {
  //           topWBarData = res;
  //         });
  //       } else {}
  //     }
  //   } on SocketException catch (_) {
  //     print('not connected');
  //   }

  //   print("ll" + topWBarData.length.toString());
  // }
  Future<void> getTopBarData() async {
    String fileName = 'getTopBarData.json';
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("reading from cache");

      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      setState(() {
        topBarData = res;
      });
    } else {
      print("reading from internet");
      var request = http.Request('GET',
          Uri.parse('https://ingnewsbank.com/api/home_top_bar_news_category?st_id=$hi'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();

        file.writeAsStringSync(body, flush: true, mode: FileMode.write);
        final res = jsonDecode(body);
        setState(() {
          topBarData = res;
        });
      } else {}
    }

    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        String fileName = 'getTopBarData.json';
        var dir = await getTemporaryDirectory();

        File file = File(dir.path + "/" + fileName);
        print("reading from internet");
        //final url = "https://ingnewsbank.com/api/home_top_bar_news_category";
        final url = "https://ingnewsbank.com/api/home_top_bar_news_category?st_id=$hi";
        final req = await http.get(Uri.parse(url));

        if (req.statusCode == 200) {
          final body = req.body;

          file.writeAsStringSync(body, flush: true, mode: FileMode.write);
          final res = jsonDecode(body);
          setState(() {
            topBarData = res;
          });
        } else {}
      }
    } on SocketException catch (_) {
      print('not connected');
    }

    // var request = http.Request('GET',
    //     Uri.parse('https://ingnewsbank.com/api/home_top_bar_news_category'));
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   var res = jsonDecode(await response.stream.bytesToString());
    //   setState(() {
    //     topBarData = res;
    //   });
    // } else {
    //   print(response.reasonPhrase);
    // }
    print("ll" + topBarData.length.toString());
  }
  
  
// var request = http.Request('GET', Uri.parse('https://ingnewsbank.com/api/get_news_world'));


// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }

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
      print(res);
      setState(() {
        topBarNewsData = res["news"]["data"];
        districtName = res["district"]["title"];
      });
    } else {
      print("reading from internet");
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://ingnewsbank.com/api/get_latest_news_by_district?page=1&did=8'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();

        file.writeAsStringSync(body, flush: true, mode: FileMode.write);
        final res = jsonDecode(body);
        setState(() {
          topBarNewsData = res["news"]["data"];
          districtName = res["district"]["title"];
        });
      } else {}
    }

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
  }
int yy=1;
  Future<void> getInfo() async {
    getTopBarData();
    getTopBarNewsData();
    getworld().then((value) {setState(() {
      yy=getallworld.length;
    });});
  }
   Future<void> getrun() async {
    setState(() {
      
    });
  }

  changePage(int value) {
    Provider.of<HomePageIndexProvider>(context, listen: false)
        .changePage(value);
  }
String hi="";
  @override
  void initState() {
    super.initState();
 getData().then((String value) {setState(() {
  //  isOpen(o)?dark=1:dark=0;
  //  if(dark==1){putColor("1");}else {putColor("0");}
                    hi=value;
                    getInfo();
                    changePage(0);
    myScroll();
    getColor().then((value) {setState(() {
      dark=value=="0"?0:1;
    });});
                  });} );               
    
  }
List<TimeOfDay> o=[TimeOfDay(hour:20,minute:00),TimeOfDay(hour:8,minute:00)];
bool isOpen(List<TimeOfDay> open)
{TimeOfDay now= TimeOfDay.now();
return (now.hour>=open[0].hour&&
       now.minute>=open[0].minute&&
       now.hour<=open[1].hour&&
       now.minute<=open[1].minute)||
       (now.hour>open[0].hour&&
       now.hour<=open[1].hour&&
       now.minute<=open[1].minute);
}
  void dispose(){
    _scrollController.removeListener(() { });
    super.dispose();
  }
  void showBottombar(){
    setState(() {
      _show=true;
    });
  }
  
  void hideBottombar(){
    setState(() {
      _show=false;
    });
  }
  void myScroll() async{
    _scrollController.addListener(() {
      if(_scrollController.position.userScrollDirection==ScrollDirection.reverse){
        if(!isscrollDown){isscrollDown=true;_showAppbar=false;hideBottombar();}
      }
    if(_scrollController.position.userScrollDirection==ScrollDirection.forward){
        if(isscrollDown){isscrollDown=false;_showAppbar=true;showBottombar();}
      }
    });
  }
   int c=0;
    List s=[];
    var getallworld;
// Future<dynamic> getworld() async {
//     var request = http.Request('GET', Uri.parse('https://ingnewsbank.com/api/get_news_world'));
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       var responseString = await response.stream.bytesToString();

//    //   print(responseString);
//     var  decode = jsonDecode(responseString);
//     getallworld=decode;
    
//     } else {
      
//       var responseString = await response.stream.bytesToString();
// print("world");
//       print(responseString);
//     }
//   }
  Future<void> getworld() async {
    String fileName = 'getWorldData.json';
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("reading from cache");

      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      setState(() {
        getallworld = res;
      });
    } else {
      print("reading from internet");
      var request = http.Request('GET',
          Uri.parse('https://ingnewsbank.com/api/get_news_world'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();

        file.writeAsStringSync(body, flush: true, mode: FileMode.write);
        final res = jsonDecode(body);
        setState(() {
          getallworld = res;
        });
      } else {}
    }

    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        String fileName = 'getWorldData.json';
        var dir = await getTemporaryDirectory();

        File file = File(dir.path + "/" + fileName);
        print("reading from internet");
        //final url = "https://ingnewsbank.com/api/home_top_bar_news_category";
        final url = "https://ingnewsbank.com/api/get_news_world";
        final req = await http.get(Uri.parse(url));

        if (req.statusCode == 200) {
          final body = req.body;

          file.writeAsStringSync(body, flush: true, mode: FileMode.write);
          final res = jsonDecode(body);
          setState(() {
            getallworld = res;
          });
        } else {}
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }



var getallState;
// Future<dynamic> getstate() async {
//     var request = http.Request('GET', Uri.parse('https://ingnewsbank.com/api/get_state'));
//     http.StreamedResponse response = await request.send();

//     if (response.statusCode == 200) {
//       var responseString = await response.stream.bytesToString();

//    //   print(responseString);
//     var  decode = jsonDecode(responseString);
//     getallState=decode;
//       c=getallState.length;
// print("state");
//     } else {
      
//       var responseString = await response.stream.bytesToString();
// print("state");
//       print(responseString);
//     }
//   }
  Future<void> getstate() async {
    String fileName = 'getStatesData.json';
    var dir = await getTemporaryDirectory();

    File file = File(dir.path + "/" + fileName);

    if (file.existsSync()) {
      print("reading from cache");

      final data = file.readAsStringSync();
      final res = jsonDecode(data);
      setState(() {
        getallState = res;
         c=getallState.length;
      });
    } else {
      print("reading from internet");
      var request = http.Request('GET',
          Uri.parse('https://ingnewsbank.com/api/get_state'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final body = await response.stream.bytesToString();

        file.writeAsStringSync(body, flush: true, mode: FileMode.write);
        final res = jsonDecode(body);
        setState(() {
          getallState = res;
           c=getallState.length;
        });
      } else {}
    }

    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        String fileName = 'getStatesData.json';
        var dir = await getTemporaryDirectory();

        File file = File(dir.path + "/" + fileName);
        print("reading from internet");
        //final url = "https://ingnewsbank.com/api/home_top_bar_news_category";
        final url = "https://ingnewsbank.com/api/get_state";
        final req = await http.get(Uri.parse(url));

        if (req.statusCode == 200) {
          final body = req.body;

          file.writeAsStringSync(body, flush: true, mode: FileMode.write);
          final res = jsonDecode(body);
          setState(() {
            getallState = res;
             c=getallState.length;
          });
        } else {}
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }
Future<bool> _onBack()async {
  if(_scaffoldKey.currentState!=null&&(_scaffoldKey.currentState!.isDrawerOpen==true))
          {   setState(() {
     //     Navigator.of(context).pop();
     _scaffoldKey.currentState!.openEndDrawer();
        });
         return Future.value(false);}
          else{
    return await  showDialog(context: context, builder: (context) =>
   new  AlertDialog(title: Text('News Bank',style:TextStyle(color: dark==0?Colors.black:Colors.white)),
   backgroundColor: dark==1?Colors.black:Colors.white,
    content: Text('क्या आप ऐप बंद करना चाहते हैं?',style:TextStyle(color: dark==0?Colors.black:Colors.white)),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            SizedBox(width: 20,),
       GestureDetector(onTap: () => Navigator.pop(context,false),child: Container( child: Text('रेटिंग दे',style:TextStyle(color:Colors.blue)))),
      SizedBox(width: 70,),
       GestureDetector(onTap: () => Navigator.pop(context,false),child: Container( child: Text('नहीं',style:TextStyle(color:Colors.blue)))),
      SizedBox(width: 20,),
    GestureDetector(onTap: () => Navigator.pop(context,true),child: Container( child: Text('बंद करें',style:TextStyle(color:Colors.blue)))),
         
         ],),
    ],
    )
    )?? false;}
  // }
  // else{return await ;}
}



  ScrollController _scrollController = ScrollController();

   final _controller = ScrollController();
bool isscrollDown = false;
bool _show= true;
double bottomBarHei=60;
double _bottombaroff=0;
    bool _showAppbar= true;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void _closeDrawer() {
  Navigator.of(context).pop();
}
_handle(){
  _scaffoldKey.currentState!.openDrawer();
}
      int _index=0;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var height = mq.height;
    var width = mq.width;




Widget  World(){
      return RefreshIndicator(
          onRefresh: () => getInfo(),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?
              Colors.blue[900]!:Colors.white),
              Container(
                height: height * 0.05,
               
                child: ListView.builder(
                    itemCount:yy==1?4: getallworld.length,
                    controller: wCoontroller,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      int ind = index == 0 ? 0 : index - 1;
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
    
                          //   topBarIndex = index == 0 ? index : index - 1;
                          // });
                          changePage(index);
                        },
                        child: Container(
                          color:dark==0?Colors.white:Colors.black,
                          height: height * 0.05,
                          width: width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Center(
                                      child: heading(
                                          text: getallworld[index]["category"]["title"].toString(),
                                          color:
                                                  topBarIndex == index
                                                      ? Colors.orange[900]!
                                                      : dark==0?Colors.blue[900]!:Colors.white

                                                      ))),
                              Container(
                                height: 3,
                                color: 
                                 topBarIndex == index
                                                      ? Colors.blue[900]!
                                                      : dark!=0?Colors.blue[900]!:Colors.white
                              
                              ),
                              SizedBox(height:10),
                            ],
                          ),
                        ),
                      );
                      //
                    }),
              ),
              Container(
                width: width,
                height: height * 0.9,
                color:dark==0?Colors.white:Colors.black,
                child: PageView.builder(
                    controller: Provider.of<HomePageIndexProvider>(context)
                        .pagecontroller,
                    onPageChanged: (value) {
                      if (Provider.of<HomePageIndexProvider>(context,
                                  listen: false)
                              .pageIndex <
                          value) {
                        wCoontroller.animateTo(
                            wCoontroller.offset + width * 0.2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                      } else if (Provider.of<HomePageIndexProvider>(context,
                                  listen: false)
                              .pageIndex >
                          value) {
                        wCoontroller.animateTo(
                            wCoontroller.offset - width * 0.2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                      }
    
                      Provider.of<HomePageIndexProvider>(context, listen: false)
                          .onlychangeIndex(value);
                      setState(() {
                        topBarIndex = value;
                      });
                    },
                    physics: ScrollPhysics(),
                    itemCount: yy==1?4: getallworld.length,
                    itemBuilder: (context, int pageindex) {
                      int ch=getallworld[pageindex]["news_world"].length;
              var h=(getallworld[pageindex]["news_world"].length/3).toInt();
                      return 
                      Container(
                height: MediaQuery.of(context).size.width*0.30*h,
               
                child: ListView.builder(
                  
                    itemCount: getallworld[pageindex]["news_world"].length%3==0?
                    h:h+1,
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, int index) {
                      int ind = index == 0 ? 0 : index - 1;
                      return Container(
                        color:dark==0?Colors.white:Colors.black,
                        height:getallworld[pageindex]["news_world"].length%3!=0?
                         MediaQuery.of(context).size.width*0.30*(h)+5:
                         pageindex==3? MediaQuery.of(context).size.width*0.30*(h-3)+5: 
                         MediaQuery.of(context).size.width*0.30*(h-1)+5,
                        width: width * 0.2,
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                  padding: const EdgeInsets.only(left:2.0),
                  child: Row(
                    children: [
                      GestureDetector(onTap:(){
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebviewScreen(
                                                      newsTitle: getallworld[pageindex]["news_world"][(index*3)]
                                                          ['title'],
                                                      newsURL:  getallworld[pageindex]["news_world"][(index*3)]["source_url"])));
                                },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width:MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.width*0.30,
                         child:Padding(
                            padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                            child: Column(
                              children: [
                            
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:10.0),
                                  child: Container(
                                        width:MediaQuery.of(context).size.width*0.27,
                          height: MediaQuery.of(context).size.width*0.17,
                                  decoration: BoxDecoration(
                                        image: DecorationImage(               
                                             image: CachedNetworkImageProvider(
                                                             getallworld[pageindex]["news_world"][(index*3)]["logo"]),
                                                          fit: BoxFit.fill),),),
                                ),
                      SizedBox(height:3),
             Text(getallworld[pageindex]["news_world"][(index*3)]["title"].toString(),style:TextStyle(fontSize: pageindex==2?10:13,color:Colors.red)),
                              ],
                            ),
                          ),
                        decoration:BoxDecoration(color:Colors.white,
                         borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(2, 2),
                                                  color: Colors.grey,
                                                  spreadRadius: 0.05)
                                            ],
                          )
                        ),
                      ),SizedBox(width:4.0),
          (ch<=((index*3)+1))?SizedBox():             GestureDetector(onTap:(){
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebviewScreen(
                                                      newsTitle: getallworld[pageindex]["news_world"][(index*3)+1]
                                                          ['title'],
                                                      newsURL:  getallworld[pageindex]["news_world"][(index*3)+1]["source_url"])));
                                },
                         child: Container(
                          alignment: Alignment.bottomCenter,
                          width:MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.width*0.30,
                         child:Padding(
                            padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                            child: Column(
                              children: [
                                Padding(
                                     padding: const EdgeInsets.only(top:8.0,bottom:10.0),
                                  child: Container(
                                        width:MediaQuery.of(context).size.width*0.27,
                          height: MediaQuery.of(context).size.width*0.17,
                                  decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(6.0),
                                        image: DecorationImage(               
                                             image: CachedNetworkImageProvider(
                                                                 getallworld[pageindex]["news_world"][(index*3)+1]["logo"]),
                                                          fit: BoxFit.fill),),),
                                ),
                      SizedBox(height:3),
                            Text(getallworld[pageindex]["news_world"][(index*3)+1]["title"].toString(),style:TextStyle(color:Colors.red,fontSize: pageindex==2?10:13)),
                              ],
                            ),
                          ),
                                         decoration:BoxDecoration(color:Colors.white,
                                          borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(2, 2),
                                                  color: Colors.grey,
                                                  spreadRadius: 0.05)
                                            ],
                          )
                                         ),
                       ),SizedBox(width:4.0),
                 (ch<=((index*3)+2))?SizedBox():      GestureDetector(onTap:(){
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebviewScreen(
                                                      newsTitle: getallworld[pageindex]["news_world"][(index*3)+2]
                                                          ['title'],
                                                      newsURL:  getallworld[pageindex]["news_world"][(index*3)+2]["source_url"])));
                                },
                         child: Container(
                          alignment: Alignment.bottomCenter,
                          width:MediaQuery.of(context).size.width*0.30,
                          height: MediaQuery.of(context).size.width*0.30,
                                        child:Padding(
                            padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                            child: Column(
                              children: [
                                Padding(
                                 padding: const EdgeInsets.only(top:8.0,bottom:10.0),
                                  child: Container(
                                        width:MediaQuery.of(context).size.width*0.27,
                          height: MediaQuery.of(context).size.width*0.17,
                                  decoration: BoxDecoration(
                                    
                                        image: DecorationImage(               
                                             image: CachedNetworkImageProvider(
                                                               getallworld[pageindex]["news_world"][(index*3)+2]["logo"]),
                                                          fit: BoxFit.fill),),),
                                ),
                      SizedBox(height:3),
                            Text(getallworld[pageindex]["news_world"][(index*3)+2]["title"].toString(),style:TextStyle(fontSize: pageindex==2?10:13,color:Colors.red),),
                              ],
                            ),
                          ),
                                         decoration:BoxDecoration(color:Colors.white,
                                          borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                                              BoxShadow(
                                                  offset: Offset(2, 2)
                                                 ,color:Colors.grey,
                                                  spreadRadius: 0.05,)
                                            ],
                          )
                                         ),
                       ),
                    ],
                  ),
                ),           
                SizedBox(height:5.0),             ],
                        ),
                      );
                      //
                    }),
              );
                      
                      
                      }),
              ),
            ],
          ),
        );
    }
    
    Widget  Home(){
      return RefreshIndicator(
          onRefresh: () => getInfo(),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
              Container(
                height: height * 0.05,
               
                child: ListView.builder(
                    itemCount: topBarData.length + 1,
                    controller: topbarCoontroller,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      int ind = index == 0 ? 0 : index - 1;
                      return GestureDetector(
                        onTap: () {
                          // setState(() {
    
                          //   topBarIndex = index == 0 ? index : index - 1;
                          // });
                          changePage(index);
                        },
                        child: Container(
                          color:dark==0?Colors.white:Colors.black,
                          height: height * 0.05,
                          width: width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Center(
                                      child: heading(
                                          text: index > 0
                                              ? topBarData[ind]["title"]
                                              : "टॉप न्यूज़",
                                          color:
                                              Provider.of<HomePageIndexProvider>(
                                                              context)
                                                          .pageIndex ==
                                                      0
                                                  ? topBarIndex == index
                                                      ? Colors.orange[900]!
                                                      : dark==0?Colors.blue[900]!:Colors.white
                                                  : topBarIndex == index - 1
                                                      ? Colors.orange[900]!
                                                      : dark==0?Colors.blue[900]!:Colors.white))),
                              Container(
                                height: 3,
                                color: Provider.of<HomePageIndexProvider>(context)
                                            .pageIndex ==
                                        0
                                    ? topBarIndex == index
                                        ? Colors.blue
                                        : Colors.white
                                    : topBarIndex == (index - 1)
                                        ? Colors.blue
                                        : Colors.white,
                              )
                            ],
                          ),
                        ),
                      );
                      //
                    }),
              ),
              Container(
                width: width,
                height: height * 0.9,
                color:dark==0?Colors.white:Colors.black,
                child: PageView.builder(
                    controller: Provider.of<HomePageIndexProvider>(context)
                        .pagecontroller,
                    onPageChanged: (value) {
                      if (Provider.of<HomePageIndexProvider>(context,
                                  listen: false)
                              .pageIndex <
                          value) {
                        topbarCoontroller.animateTo(
                            topbarCoontroller.offset + width * 0.2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                      } else if (Provider.of<HomePageIndexProvider>(context,
                                  listen: false)
                              .pageIndex >
                          value) {
                        topbarCoontroller.animateTo(
                            topbarCoontroller.offset - width * 0.2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                      }
    
                      Provider.of<HomePageIndexProvider>(context, listen: false)
                          .onlychangeIndex(value);
                      setState(() {
                        topBarIndex = value == 0 ? value : value - 1;
                      });
                    },
                    physics: ScrollPhysics(),
                    itemCount: topBarData.length + 1,
                    itemBuilder: (context, int pageindex) {
                      return Provider.of<HomePageIndexProvider>(context)
                                  .pageIndex ==
                              0
                          ? TopNews(_scrollController)
                          : TopBarCategory(_scrollController,
                              cpId: topBarData[pageindex - 1]["cp_id"]);
                    }),
              ),
            ],
          ),
        );
    }


    Widget  Anayee(){
      return RefreshIndicator(
          onRefresh: () => getrun(),
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
              Container(
                height: height * 0.05,
               
                child: ListView.builder(
                    itemCount: states,
                    controller:  arCoontroller,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      int ind = index == 0 ? 0 : index - 1;
                      return GestureDetector(
                        onTap: () {changePage(index);
                        },
                        child:  Container(
                          color:dark==0?Colors.white:Colors.black,
                          height: height * 0.05,
                          width: width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Center(
                                      child:heading(
                                          text: si[index+1].toString(),
                                          color: topWBarIndex == index
                                                      ? Colors.orange[900]!
                                                      : dark==0?Colors.blue[900]!:Colors.white
                                                 ))),
                        Container(
                                height: 3,
                                color: topWBarIndex == index
                                        ? Colors.blue
                                        : Colors.white
                              )
                            ],
                          ),
                        ),
                      );
                      //
                    }),
              ),
              Container(
                width: width,
                height: height * 0.9,
                color:dark==0?Colors.white:Colors.black,
                child: PageView.builder(
                    controller: Provider.of<HomePageIndexProvider>(context)
                        .pagecontroller,
                    onPageChanged: (value) {
                      if (Provider.of<HomePageIndexProvider>(context,
                                  listen: false)
                              .pageIndex <
                          value) {
                        arCoontroller.animateTo(
                            arCoontroller.offset + width * 0.2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                        //      getTop(value+1).then((value) {setState(() {
                        // });});
                      } else if (Provider.of<HomePageIndexProvider>(context,
                                  listen: false)
                              .pageIndex >
                          value) {
                        arCoontroller.animateTo(
                            arCoontroller.offset - width * 0.2,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                        //      getTop(value+1).then((value) {setState(() {
                        // });});
                      }
    
                      Provider.of<HomePageIndexProvider>(context, listen: false)
                          .onlychangeIndex(value);
                      setState(() {
                        topWBarIndex = value;
                      });
                    },
                    physics: ScrollPhysics(),
                    itemCount: states,
                    itemBuilder: (context, int pageindex) {
                      return
                      //  Provider.of<HomePageIndexProvider>(context)
                      //             .pageIndex.toString() ==
                      //         hi
                      //     ? SizedBox()
                      //     : 
                            //     Container(child:Text(topWBarIndex.toString()));

                          TopBarCategory(_scrollController,
                              cpId: cat[topWBarIndex]);
                    }),
              ),
            ],
          ),
        );
    }
      List<Widget> _pages=<Widget>[
      Home(),
      Container(),
      Anayee(),
      Container(),
      World(),


    ];
void _onItem(int index){
setState(() {
              changePage(0);
              this._index=index;
            });
}
 
    return WillPopScope(
      child: Scaffold(
        key:_scaffoldKey,
        
        bottomNavigationBar:  Container(
          height: _show? bottomBarHei:0,
          width: MediaQuery.of(context).size.width,
          child: !_show? Container(width:MediaQuery.of(context).size.width,):
          BottomNavigationBar(
            backgroundColor: dark==0?Colors.white:Colors.grey[700],
            currentIndex: _index,
            onTap: _onItem,
            selectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home, color:dark==0?Colors.black:Colors.white,), label: "होम",),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.place,
                  color:dark==0?Colors.black:Colors.white,
                ),
                label: "मेरा शहर",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.map,
                   color:dark==0?Colors.black:Colors.white,
                  ),
                  label: "अन्य राज्य"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.timeline,
                    color:dark==0?Colors.black:Colors.white,
                  ),
                  label: "ट्रेंडिंग"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.language,
                  color:dark==0?Colors.black:Colors.white,
                  ),
                  label: "न्यूज वर्ल्ड",
                  
                  )
            ],
          ),
        ),
        appBar: !_showAppbar?PreferredSize(preferredSize: Size(0.0,0.0),child:Container(),): ScrollAppBar(
          controller: _controller,
            brightness: Brightness.dark,
          backgroundColor: dark==0?Colors.blue[900]:Colors.black,
          leading:new IconButton(icon :Icon(Icons.menu),onPressed:_handle),
          title: heading(text: "News Bank", color:  Colors.white),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                  }  ,
                child: Icon(Icons.search,)),
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LiveTVScreen()));
                },
                child: Icon(Icons.tv)),
            SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RadioScreen()));
                },
                child: Icon(Icons.radio)),
            SizedBox(width: 10),
            Icon(Icons.bookmark),
            SizedBox(width: 10),
            Icon(Icons.notifications),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            child: SingleChildScrollView(
              child: Container(color:dark==0?Colors.white:Colors.black,
                child: Column(
    
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                              Image.asset("images/icon.png", height: 100, width: 100),
                              SizedBox(width:10),
                              Column(children: [
                            Text(
                            "NEWS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 25),
                          ),
                           Text(
                            "BANK",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 25),
                          ),
    
                              ],),
                           
                          
                          
                        ],
                      ),
                    ),
                    Text(
                            "पल पल की खबर, हर पल",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: 18),
                          ),
                  dark==0?  Divider(
                      thickness: 1,
                    ):  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                    ),
            Theme( data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                 
                        leading: Icon(
                          Icons.circle_notifications,
                          color:dark==0 ?Colors.black:Colors.white,
                        ),
                        title: Text(
                          "डार्क मोड",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                size: 22,
              ),
              children: [
                ListTile(
                    visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                          dense:true,
                  leading: Icon(
                    dark==0?Icons.circle_rounded:Icons.circle_outlined,color:dark==0?Colors.black:Colors.white,
                    size: 18,
                  ), contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Off',
                    style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                  ),
                  onTap: () {
                   setState(() {
                            if(dark==1){dark=0;putColor("0");}
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
                          });
                  },
                ),
                ListTile(
                    visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                          dense:true,
               contentPadding: EdgeInsets.only(left: 20),
                  leading: Icon(
                    dark==0?Icons.circle_outlined
                    :Icons.circle_rounded,color:dark==0?Colors.black:Colors.white,
                    size: 18,
                  ),
                  title: Text(
                    'On',
                    style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                  ),
                  onTap: () {
                   setState(() {
                            if(dark==0){dark=1;putColor("1");}
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
                          });
                  },
                ),
                 ListTile(
                    visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                          dense:true,
               contentPadding: EdgeInsets.only(left: 20),
                  leading: Icon(
                    Icons.circle_outlined,color:dark==0?Colors.black:Colors.white,
                    size: 18,
                  ),
                  title: Text(
                    'Automatic at sunset',
                    style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                  ),
                  onTap: () {
                   setState(() {
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
                          });
                  },
                ),
              ],
                      ),
            ),
                   dark==0? Divider(thickness: 1,):  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                   ),
            
                    ListTile(
                      visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {},
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.share,
                    color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "ऐप शेयर करें",
                        style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                    
                    ListTile(
                      visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {},
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.download,
                       color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "ऐप अपडेट करें",
                        style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                      ),
                    ),ListTile(
                      visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {},
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.star,
                     color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "रेटिंग दें",
                        style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                    dark==0? Divider(thickness: 1,):  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                    ),
            
                    ListTile(visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RadioScreen()));
                      },
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.radio,
                       color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "रेडियो",
                        style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                    ListTile(visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LiveTVScreen()));
                      },
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.tv,
                       color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "लाइव टीवी",
                        style: TextStyle(fontSize: 18,color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                    dark==0? Divider(thickness: 1,):  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                    ),
            
                    ListTile(visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                       onTap: () {
                         getgallary().then((value) {
                         setState(() {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => News_Gallery(_scrollController)),);
                        }); 
                         });
                       
                      },
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.image_not_supported_outlined,
                       color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "न्यूज गैलरी",
                        style: TextStyle(fontSize: 16,color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                    ListTile(visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                       onTap: () {
                      },
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.feedback_rounded,
                        color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "अपना फीडबैक/सुझाव साझा करें",
                        style: TextStyle(fontSize: 15,color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                     dark==0? Divider(thickness: 1,):  Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                     ),
            
                    ListTile(visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {},
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.rule_folder,
                      color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "नियम और शर्तें",
                        style: TextStyle(fontSize: 16,color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                    ListTile(visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {},
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.info,
                       color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "हमारे बारे में",
                        style: TextStyle(fontSize: 15,color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                   
                               Theme( data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                 
                        leading: Icon(
                          Icons.notification_important,
                          color:dark==0 ?Colors.black:Colors.white,
                        ),
                        title: Text(
                          "नोटिफिकेशन सेटिंग्स",
                          style: TextStyle(fontSize: 18, color:dark==0 ?Colors.black:Colors.white,),
                        ),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                size: 22,
              ),
              children: [
                ListTile(
                    visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                          dense:true,
                  leading: Icon(
                    dark==0?Icons.circle_rounded:Icons.circle_outlined,color:dark==0?Colors.black:Colors.white,
                    size: 18,
                  ), contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Allow Notifications',
                    style: TextStyle(fontSize: 15, color:dark==0? Colors.black:Colors.white),
                  ),
                  onTap: () {
                
                  },
                ),
                ListTile(
                    visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                          dense:true,
               contentPadding: EdgeInsets.only(left: 20),
                  leading: Icon(
                    dark==0?Icons.circle_outlined
                    :Icons.circle_rounded,color:dark==0?Colors.black:Colors.white,
                    size: 18,
                  ),
                  title: Text(
                    'Off Notifications 6:00 pm to 7:00 am',
                    style: TextStyle(fontSize: 15, color:dark==0? Colors.black:Colors.white),
                  ),
                  onTap: () {
                
                  },
                ),
                 ListTile(
                    visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                          dense:true,
               contentPadding: EdgeInsets.only(left: 20),
                  leading: Icon(
                    Icons.circle_outlined,color:dark==0?Colors.black:Colors.white,
                    size: 18,
                  ),
                  title: Text(
                    'Sounds',
                    style: TextStyle(fontSize: 15, color:dark==0? Colors.black:Colors.white),
                  ),
                  onTap: () {
                   setState(() {
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
                          });
                  },
                ),
ListTile(
                    visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                          dense:true,
               contentPadding: EdgeInsets.only(left: 20),
                  leading: Icon(
                    Icons.circle_outlined,color:dark==0?Colors.black:Colors.white,
                    size: 18,
                  ),
                  title: Text(
                    'Vibration',
                    style: TextStyle(fontSize: 15, color:dark==0? Colors.black:Colors.white),
                  ),
                  onTap: () {
                   setState(() {
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
                          });
                  },
                ),
              ],
                      ),
            ),
 
                   dark==0? Divider(thickness: 1,):  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                   ),
            
                                    ListTile(
                      visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {     getstate().then((value) {setState(() {
s.add("अपना राज्य चुनें");
                                    for(int  i=0;i<c;i++)
                                    {s.add(getallState[i]["title"].toString());                                  }
print(s.length);
                    Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => StatesScreen(s)),(route) => false);
                            // MyApps(s)),(route) => false);
                    });});
             },
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.share,
                      color:dark==0? Colors.black:Colors.white
                      ),
                      title: Text(
                        "अपना राज्य बदलें",
                        style: TextStyle(fontSize: 18, color:dark==0? Colors.black:Colors.white),
                      ),
                    ),
                      dark==0? Divider(thickness: 1,):  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                      ),          
                        ListTile(
                      visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {   
             setState(() {
               exit(0);
             });
             },
                      contentPadding: EdgeInsets.only(left: 20),
                      leading: Icon(
                        Icons.exit_to_app,
                      color:Colors.blue
                      ),
                      title: Text(
                        "EXIT FROM NEWS BANK",
                        style: TextStyle(fontSize: 19, color:Colors.blue),
                      ),
                    ),
                      dark==0? Divider(thickness: 1,):  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
                      ),
            
                        ListTile(
                      visualDensity:VisualDensity(horizontal: 2,vertical:-4),
                        dense:true,
                      onTap: () {   
             },
                      contentPadding: EdgeInsets.only(left: 100),
                     
                      title: Text(
                        "Powered By:",
                        style: TextStyle(fontSize: 14, color:Colors.red),
                      ),
                    ),
                  
                        ListTile(
                      visualDensity:VisualDensity(horizontal: 0,vertical:-4),
                        dense:true,
                      onTap: () {   
             },
                      contentPadding: EdgeInsets.only(left: 50),
                     
                      title: Text(
                        "Independent News Group",
                        style: TextStyle(fontSize: 20, color:Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body:_pages.elementAt(_index),
    //   World(),
     //   Home(),
       //  Anayee(),
      ),
      onWillPop:  _scaffoldKey.currentState!=null&&(_scaffoldKey.currentState!.isDrawerOpen==true)?(){
        setState(() {
     //     Navigator.of(context).pop();
     _scaffoldKey.currentState!.openEndDrawer();
        });
         return Future.value(false);
      } :_index==0?_onBack:(){
        // Navigator.push(context,
               setState(() {
          if(_scaffoldKey.currentState!=null&&(_scaffoldKey.currentState!.isDrawerOpen==true))
          {  _scaffoldKey.currentState!.openEndDrawer();}
              else  {changePage(0); _index=0; }
               });   //  MaterialPageRoute(builder: (context) => HomeScreen())
                      //);
                      return Future.value(false);},
    );
  }

  Future<dynamic> getPageData({@required String? cpId}) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://ingnewsbank.com/api/home_top_bar_news_of_category?cp_id=$cpId&page=1'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      print(data);
      return data["data"];
    } else {
      print(response.reasonPhrase);
    }
  }
}



    
              



    // Widget  Anaye(){
    //   return RefreshIndicator(
    //       onRefresh: () => getInfo(),
    //       child: ListView(
    //         shrinkWrap: true,
    //         physics: ScrollPhysics(),
    //         children: [
    //           Container(height: 1.0,width: MediaQuery.of(context).size.width*1,color:dark==0?Colors.blue[900]!:Colors.white),
    //           Container(
    //             width: width,
    //             height: height * 0.9,
    //             color:dark==0?Colors.white:Colors.black,
    //              child:AneyRajye(_scrollController)
    //           ),
    //         ],
    //       ),
    //     );
    // }

