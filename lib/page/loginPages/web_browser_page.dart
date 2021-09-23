import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowserPage extends StatefulWidget{
  var url;

  WebBrowserPage(this.url);

  @override
  WebBrowserPageState createState() => WebBrowserPageState();
}

class WebBrowserPageState extends State<WebBrowserPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var close_btn = IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.white,
      iconSize: 21,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: close_btn,
      ),
      body: _buildBodyWidget(),
    );
  }

  _buildBodyWidget() {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      // onPageFinished: _loginVerfiy,
    );
  }
}