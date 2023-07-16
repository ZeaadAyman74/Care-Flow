import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class MedicineRecommenderScreen extends StatefulWidget {
  const MedicineRecommenderScreen({Key? key}) : super(key: key);

  @override
  State<MedicineRecommenderScreen> createState() => _MedicineRecommenderScreenState();
}

class _MedicineRecommenderScreenState extends State<MedicineRecommenderScreen> {
  double _progress=0;
  late InAppWebViewController inAppWebViewController;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Recommender'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse('https://medix-e-rkmndr-kh-basetgi-e4zrdqcfhu.streamlit.app/'),
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
