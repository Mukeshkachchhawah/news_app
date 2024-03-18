import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

  String? linkUrl;
class OpenUrl extends StatefulWidget {

   OpenUrl({super.key, required String curl}){
     linkUrl = curl;
   }
  

  @override
  State<OpenUrl> createState() => _OpenUrlState();
}

class _OpenUrlState extends State<OpenUrl> {

  WebViewController getWebViewController(){
    var controller = WebViewController()..setJavaScriptMode(JavaScriptMode.disabled)..loadRequest(Uri.parse(linkUrl.toString()));
    return controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///TODO new web view 

      body: WebViewWidget(controller: getWebViewController()),
    );
  }
}