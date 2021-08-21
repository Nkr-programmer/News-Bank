import 'dart:io';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news/provider/homePageIndex_provider.dart';
import 'package:news/provider/string.dart';
import 'package:news/screens/home_screen/home_screen.dart';
import 'package:news/screens/home_screen/states_screen.dart';
import 'package:flutter/material.dart';
import 'package:news/widgets/no_internet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'homePage.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageIndexProvider()),
      ],
      child: MaterialApp(
        home: MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    var d = const Duration(milliseconds: 100);
    // delayed 3 seconds to next page
    int c = 0;
    int x=0;
    List s = [];
    var getallState;
    
//     Future<dynamic> getstate() async {
//       try{
//       var request = http.Request(
//           'GET', Uri.parse('https://ingnewsbank.com/api/get_state'));
//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         var responseString = await response.stream.bytesToString();
//         print(responseString);
//         var decode = jsonDecode(responseString);
//         getallState = decode;
//         c = getallState.length;
//         print(getallState.length.toString());
//       } else {
//         var responseString = await response.stream.bytesToString();
// x=0;
//         print(responseString);
//       }
//       }
//        on SocketException catch (_) {
//       setState(() {
//         x=1;
//         Toast.show("आपका इंटरनेट बंद है |", context);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
//       });
//     }
//     }

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
      } else {x=0;}
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
        } else {x=0;}
      }
    } on SocketException catch (_) {
       setState(() {
        x=1;
        Toast.show("आपका इंटरनेट बंद है |", context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      });
    }
  }

    Future.delayed(d, () {
      getstate().then((value) {
 if(x==0){       setState(() {
          s.add("अपना राज्य चुनें");
          states = c;
          for (int i = 0; i < c; i++) {
            s.add(getallState[i]["title"].toString());
          }
          si = s;
          print(s.length);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      //StatesScreen(s)),(route) => false);
                      MyApps(s)),
              (route) => false);
        });}
      });
 
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken),
          image: AssetImage('images/hdpi_splash.png'),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }
}

class MyApps extends StatefulWidget {
  MyApps(this.s, {Key? key}) : super(key: key);
  List s;
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  Future<String> getData() async {
    String fileName = 'state_id.txt';
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      final data = file.readAsStringSync();
      return data;
    } else {
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != "0") {
            return HomeScreen();
          } else {
            return StatesScreen(widget.s);
          }
        });
  }
}



// void main() {
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider(create: (_) => HomePageIndexProvider()),
//   ], child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   Future<String> getData() async {
//     String fileName = 'state_id.txt';
//     var dir = await getTemporaryDirectory();
//     File file = File(dir.path + "/" + fileName);
//     if (file.existsSync()) {
//       final data = file.readAsStringSync();
//       return data;
//     } else {
//       return "0";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FutureBuilder(
//         future: getData(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.data != "0") {
//             return HomeScreen();
//           } else {
//             return StatesScreen();
//           }
//         }),
//     );
//   }
// }
