import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
int dark=0;
List cat=[10,23,24,26,28,29,25,27];
 String fileName = 'state_id.txt';
  String mode = 'color_id.txt';
putColor(color) async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + mode);
    file.writeAsStringSync(color, flush: true, mode: FileMode.write);
  }
  Future<String> getColor() async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + mode);
    if (file.existsSync()) {
      final data = file.readAsStringSync();
      return data;
    } else {
      return "0";
    }
  }

putData(stateId) async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    file.writeAsStringSync(stateId, flush: true, mode: FileMode.write);
  }
int states=0;
 List si=[];
  Future<String> getData() async {
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      final data = file.readAsStringSync();
      return data;
    } else {
      return "0";
    }
  }
  var getallgallary;
Future<dynamic> getgallary() async {
    var request = http.Request('GET', Uri.parse('https://ingnewsbank.com/api/get_news_gallery'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();

   //   print(responseString);
    var  decode = jsonDecode(responseString);
    getallgallary=decode;
      print(getallgallary.length.toString());
print("gallary");
    } else {
      
      var responseString = await response.stream.bytesToString();
print("gallary");
      print(responseString);
    }
  }