import 'dart:io';

import 'package:news/provider/string.dart';
import 'package:news/widgets/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  String newsTitle;
  String newsURL;
  WebviewScreen({required this.newsTitle, required this.newsURL});
  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: ScrollAppBar(
          controller: controller,
          actions: [
            GestureDetector(
                onTap: () {
                  Share.share(widget.newsTitle);
                },
                child: Icon(Icons.share, color: Colors.white)),
            SizedBox(width: 14),
            PopupMenuButton<int>(
              color: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    value: 0,
                    child: GestureDetector(
                      onTap: () {
                        {
                          FlutterShare.share(
                              title: "Title",
                              text: widget.newsTitle,
                              chooserTitle: "इस खबर को शेयर करो.....");
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text("Share"),
                        ],
                      ),
                    )),
                PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.sync,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Refresh"),
                      ],
                    )),
                PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Add to Bookmarks"),
                      ],
                    )),
                PopupMenuItem<int>(
                    value: 3,
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Notification"),
                      ],
                    )),
                PopupMenuItem<int>(
                    value: 4,
                    child: Row(
                      children: [
                        Icon(
                          Icons.open_in_browser,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text("Open in external browser"),
                      ],
                    )),
              ],
            ),
          ],
          backgroundColor: dark==0?Colors.blue[900]:Colors.black,
          title: heading(
              text: widget.newsTitle,
              color: Colors.white,
              scale: 0.8,
              maxLines: 1),
        ),
      ),
      body: WebView(
        initialUrl: widget.newsURL,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
