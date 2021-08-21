import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news/provider/string.dart';
import 'package:news/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StatesScreen extends StatefulWidget {
   StatesScreen(this.s, {Key? key}) : super(key: key);
List s;
  @override
  _StatesScreenState createState() => _StatesScreenState();
}

class _StatesScreenState extends State<StatesScreen> {
 int c=1;
  String bloodgroupvalue=  "अपना राज्य चुनें";
  List x=["jgj"];
 
  @override
  
List<TimeOfDay> o=[TimeOfDay(hour:22,minute:58),TimeOfDay(hour:8,minute:00)];
bool isOpen(List<TimeOfDay> open)
{TimeOfDay now= TimeOfDay.now();
return now.hour>=open[0].hour&&
       now.minute>=open[0].minute&&
       now.hour<=open[1].hour&&
       now.minute<=open[1].minute;
}
  void initState() {
    getColor().then((value) {setState(() {
//isOpen(o)?dark=1:dark=0;
  // if(dark==1){putColor("1");}else {putColor("0");}
      dark=value=="0"?0:1;
    });});
  x=widget.s;
setState(() {
  
});
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            
                //   RawMaterialButton(
                //       constraints: BoxConstraints.tight(Size(150,80)),
                //     onPressed: () { setState(() {
                //        getstate().then((value) {setState(() {
                //       putData(getallState[4]["sid"].toString());              
                //   Navigator.pushAndRemoveUntil(context,
                //           MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
                //   });});
                // });
                //     },
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5)),
                //     fillColor: Colors.orange,
                //     child: Padding(
                //       padding: const EdgeInsets.all(2),
                //       child: Text(
                //         "मध्य प्रदेश", textScaleFactor: 1.0,
                //         style: TextStyle(color: Colors.white, fontSize: 20),
                //       ),
                //     ),
                //   ),
                 Container(
                   height: MediaQuery.of(context).size.height*1,
                    width: MediaQuery.of(context).size.width*1,
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken),
          image: AssetImage('images/s1.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      
    ),
                   Container(
                     height:50,width:250,
                     child: Center(
                       child: Container(height:50,width:250,color:dark==0?Colors.white:Colors.white,
                         child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(
                                      ),
                     
                                      hint: Icon(Icons.arrow_drop_down_outlined,color:dark==0?Colors.white:Colors.black,),
                     
                                      value: bloodgroupvalue,
                                      onChanged: (newval){
                                        setState(() {
                                          bloodgroupvalue=newval.toString();
                                          print(bloodgroupvalue);
                                          setState(() {
                                    int h=x.lastIndexWhere((element) => element==bloodgroupvalue);
if(h>0){putData(h.toString());
                  Navigator.pushAndRemoveUntil(context,
                           MaterialPageRoute(builder: (context) => HomeScreen()),(route) => false);
                                          }});
                                        });
                                      },
                                      items:x.map((e){
                                        return DropdownMenuItem<String>(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:8.0),
                                            child: Container(width:250,height:50,color:dark==0?Colors.white:Colors.black,alignment: Alignment.centerLeft,
                                              child: Text(e.toString(),textAlign: TextAlign.center,style: 
                                              TextStyle(color:dark==0?Colors.black:Colors.white,fontSize: 25.0),
                                              ),
                                            ),
                                          ),
                                        value: e,);
                                      }).toList(),
                                    ),
                       ),
                     ),
                   ),
            
          ],
        ),
      ),
    );
  }
}