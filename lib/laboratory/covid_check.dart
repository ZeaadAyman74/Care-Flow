import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CovidCheck extends StatefulWidget {
  const CovidCheck({Key? key}) : super(key: key);

  @override
  State<CovidCheck> createState() => _CovidCheckState();
}

class _CovidCheckState extends State<CovidCheck> {
  double _progress=0;
  late InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Check'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse('https://cbc-cvd19-detector-kh-abst.onrender.com/'),
            ),
            onWebViewCreated: (controller) {
              inAppWebViewController=controller;
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                _progress=progress/100;
              });
            },
          ),
          if (_progress<1) Center(
            child: CircularProgressIndicator(
              value: _progress,
            ),
          ) else const SizedBox(),
        ],
      ),
    );
  }
}
