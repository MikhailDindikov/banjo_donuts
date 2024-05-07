import 'package:banjo_donuts/hern/pomo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DonScoresScr extends StatefulWidget {
  const DonScoresScr({super.key});

  @override
  State<DonScoresScr> createState() => _DonScoresScrState();
}

class _DonScoresScrState extends State<DonScoresScr> {
  RxString _curDonScore = '30'.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/dons_bg.png'),
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
                  'record\ntable'.toUpperCase(),
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
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      'assets/game/cat.png',
                      filterQuality: FilterQuality.high,
                      height: 238,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      top: 238,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/korzina.png',
                            filterQuality: FilterQuality.high,
                            height: 125,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Obx(
                              () => Text(
                                (Pomo.pomo!.getInt(
                                            '${_curDonScore.value}_score') ??
                                        '0')
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 151,
                ),
                Obx(
                  () => Text(
                    (Pomo.pomo!.getString('${_curDonScore.value}_date') ?? '-')
                        .toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  //margin: EdgeInsets.symmetric(horizontal: 26),
                  constraints: BoxConstraints(minHeight: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(176, 87, 246, 1),
                        Color.fromRGBO(209, 155, 251, 1),
                        Color.fromRGBO(178, 79, 255, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        color: Color.fromRGBO(147, 62, 213, 1),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(160, 75, 226, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            _curDonScore.value = '30';
                          },
                          child: Obx(
                            () => _donRecElem(_curDonScore.value == '30',
                                '30 sec'.toUpperCase()),
                          ),
                        )),
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _curDonScore.value = '45';
                                },
                                child: Obx(
                                  () => _donRecElem(_curDonScore.value == '45',
                                      '45 sec'.toUpperCase()),
                                ))),
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _curDonScore.value = '60';
                                },
                                child: Obx(
                                  () => _donRecElem(_curDonScore.value == '60',
                                      '60 sec'.toUpperCase()),
                                ))),
                        Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  _curDonScore.value = '120';
                                },
                                child: Obx(
                                  () => _donRecElem(_curDonScore.value == '120',
                                      '120 sec'.toUpperCase()),
                                ))),
                      ],
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

  Widget _donRecElem(bool isActive, String donRecTitle) => !isActive
      ? Container(
          padding: EdgeInsets.all(3),
          alignment: Alignment.center,
          child: Text(
            donRecTitle,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(56, 56, 56, 1),
            ),
          ),
        )
      : Container(
          padding: EdgeInsets.only(bottom: 3),
          decoration: BoxDecoration(
            color: Color.fromRGBO(108, 0, 191, 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(197, 123, 255, 1),
                Color.fromRGBO(143, 27, 234, 1),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              donRecTitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        );
}
