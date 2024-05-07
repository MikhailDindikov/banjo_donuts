import 'package:banjo_donuts/hern/pomo.dart';
import 'package:banjo_donuts/sssc/don_game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DonSelector extends StatelessWidget {
  const DonSelector({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: Get.back,
                    child: Image.asset(
                      'assets/buttons/back_btn.png',
                      height: 58,
                      width: 58,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'select a\ntime mode'.toUpperCase(),
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
                  height: 68,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => DonGame(
                              seconds: 30,
                            ),
                          );
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
                            '30 sec'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => DonGame(
                              seconds: 45,
                            ),
                          );
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
                            '45 sec'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => DonGame(
                              seconds: 60,
                            ),
                          );
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
                            '60 sec'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Pomo.pomo!.getBool('donpr') ?? false) {
                            Get.to(
                              () => DonGame(
                                seconds: 120,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          constraints: BoxConstraints(minHeight: 60),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      Pomo.pomo!.getBool('donpr') ?? false
                                          ? 'assets/buttons/purple_btn.png'
                                          : 'assets/buttons/pink_btn.png'),
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Text(
                            '120 sec',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Opacity(
                        opacity: Pomo.pomo!.getBool('donpr') ?? false ? 0 : 1,
                        child: Text(
                          'aviable only with premium'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Baloo',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
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
