import 'dart:ui';

import 'package:banjo_donuts/hern/pomo.dart';
import 'package:banjo_donuts/hern/zvuki.dart';
import 'package:banjo_donuts/mu_co.dart';
import 'package:banjo_donuts/sssc/don_prem_scr.dart';
import 'package:banjo_donuts/sssc/don_scores_scr.dart';
import 'package:banjo_donuts/sssc/don_selector.dart';
import 'package:banjo_donuts/sssc/vsyakoe_scr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DonScr extends StatefulWidget {
  const DonScr({super.key});

  @override
  State<DonScr> createState() => _DonScrState();
}

class _DonScrState extends State<DonScr> {
  final RxBool musDan = (Pomo.pomo!.getBool('donms') ?? true).obs;
  final _mmmgovno = Get.put(MuCo());

  @override
  void initState() {
    super.initState();
    if ((Pomo.pomo!.getBool('donms') ?? true) && !Zvuki.musPlDon) {
      Zvuki.goDonMu('ms.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MuCo>(builder: (_) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/don_bg.png'),
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        musDan.toggle();
                        if (musDan.value) {
                          Zvuki.goDonMu('ms.mp3');
                          Pomo.pomo!.setBool('donms', true);
                        } else {
                          Zvuki.stoDonMu();
                          Pomo.pomo!.setBool('donms', false);
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/buttons/music_btn.png',
                            filterQuality: FilterQuality.high,
                            width: 63,
                          ),
                          Obx(
                            () => AnimatedOpacity(
                              opacity: musDan.value ? 0 : 1,
                              duration: Duration(milliseconds: 150),
                              child: Image.asset(
                                'assets/buttons/off.png',
                                filterQuality: FilterQuality.high,
                                width: 48,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => DonSelector());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            constraints: BoxConstraints(minHeight: 60),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/buttons/pink_btn.png'),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Text(
                              'PLAY',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => DomPremScr());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            constraints: BoxConstraints(minHeight: 60),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/buttons/purple_btn.png'),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Text(
                              'premium'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => DonScoresScr());
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            constraints: BoxConstraints(minHeight: 60),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/buttons/purple_btn.png'),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Text(
                              'record table'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: _baus,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            constraints: BoxConstraints(minHeight: 60),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/buttons/purple_btn.png'),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Text(
                              'about us'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _baus() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: IntrinsicHeight(
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 46,
                          top: 12,
                          right: 46,
                          bottom: 30,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/pr_bg.png'),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'ABOUT US',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => VsyakoeScr(
                                        vsakoe: Vsakoe.pr,
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  constraints: BoxConstraints(minHeight: 60),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/buttons/purple_btn.png'),
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(8)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'privacy policy'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => VsyakoeScr(
                                        vsakoe: Vsakoe.te,
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  constraints: BoxConstraints(minHeight: 60),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/buttons/purple_btn.png'),
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(8)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'terms of use'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => VsyakoeScr(
                                        vsakoe: Vsakoe.su,
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  constraints: BoxConstraints(minHeight: 60),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/buttons/purple_btn.png'),
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(8)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'support'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: -15,
                        top: -24,
                        child: GestureDetector(
                          onTap: Get.back,
                          child: Image.asset(
                            'assets/buttons/close_btn.png',
                            filterQuality: FilterQuality.high,
                            height: 64,
                            width: 64,
                          ),
                        ),
                      ),
                    ],
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
