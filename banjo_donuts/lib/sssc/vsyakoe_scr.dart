import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum Vsakoe { su, pr, te }

class VsyakoeScr extends StatefulWidget {
  final Vsakoe vsakoe;
  const VsyakoeScr({required this.vsakoe, super.key});

  @override
  State<VsyakoeScr> createState() => _VsyakoeScrState();
}

class _VsyakoeScrState extends State<VsyakoeScr> {
  late WebViewController controllerFab;
  String fabTi = '';
  @override
  void initState() {
    controllerFab = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
        widget.vsakoe == Vsakoe.su
            ? 'https://sites.google.com/view/luna-eai-sia/support'
            : widget.vsakoe == Vsakoe.te
                ? 'https://www.termsfeed.com/live/16aa9929-9580-471a-95a3-ce2d9b4faddc'
                : 'https://www.termsfeed.com/live/af7185f9-9687-44a7-9ac4-0ae466666801',
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/ob_bg.png'),
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: Get.back,
                    child: Image.asset(
                      'assets/buttons/back_btn.png',
                      filterQuality: FilterQuality.high,
                      width: 63,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.vsakoe == Vsakoe.su
                      ? 'support'.toUpperCase()
                      : widget.vsakoe == Vsakoe.te
                          ? 'terms of use'.toUpperCase()
                          : 'privacy policy'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 4),
                        blurRadius: 0,
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                      Shadow(
                          offset: Offset(-2, -2),
                          color: Color.fromRGBO(32, 52, 124, 1)),
                      Shadow(
                          offset: Offset(2, -2),
                          color: Color.fromRGBO(32, 52, 124, 1)),
                      Shadow(
                          offset: Offset(2, 2),
                          color: Color.fromRGBO(32, 52, 124, 1)),
                      Shadow(
                          offset: Offset(-2, 2),
                          color: Color.fromRGBO(32, 52, 124, 1)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: WebViewWidget(
                      controller: controllerFab,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
