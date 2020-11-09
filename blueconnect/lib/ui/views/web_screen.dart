import 'dart:io';
import 'dart:async';
import 'package:blueconnectapp/core/veiwModels/webview_model.dart';
import 'package:blueconnectapp/ui/shared/colors.dart';
import 'base_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  final String url;

  const WebScreen({Key key, this.url}) : super(key: key);

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  Completer<WebViewController> _controller;
  @override
  Widget build(BuildContext context) {
    return BaseView<WebViewModel>(
      onModelReady: (model) {
        if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
        _controller = Completer<WebViewController>();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: KPrimaryColor2,
          title: Text(
            "Blue Connect",
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
            ),
          ),
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              model.isLoading? LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(KPrimaryColor2),
              ) : Container(),
              Expanded(
                child: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  gestureNavigationEnabled: true,
                  onPageFinished: (_){
                    model.finishLoading();
                  },
                  onPageStarted: (_){
                    model.startLoading();
                  },
                  onWebViewCreated: (WebViewController controller){
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
