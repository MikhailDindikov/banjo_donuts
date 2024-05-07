import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_composite_model.dart';
import 'package:banjo_donuts/hern/pomo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DomPremScr extends StatefulWidget {
  const DomPremScr({super.key});

  @override
  State<DomPremScr> createState() => _DomPremScrState();
}

class _DomPremScrState extends State<DomPremScr> {
  RxBool prDonLo = false.obs;
  RxBool puDonLo = false.obs;
  RxBool prDomAct = (Pomo.pomo!.getBool('donpr') ?? false).obs;

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
                  'PREMIUM',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/game/happy_ham.png',
                        filterQuality: FilterQuality.high,
                        height: 144,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 18,
                          top: 48,
                          right: 18,
                          bottom: 68,
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'no '.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'Titan',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'ads\n'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'Titan',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(0, 87, 255, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'one '.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'Titan',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'extralife\n'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'Titan',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(158, 255, 156, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '120 sec '.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'Titan',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(250, 255, 0, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'more'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontFamily: 'Titan',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 62,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (!prDonLo.value && !prDomAct.value) {
                                    prDonLo.value = true;
                                    prDomAct.value = true;
                                    final donpw = await Apphud.paywalls();

                                    final donotv = await Apphud.purchase(
                                      product: donpw?.paywalls.first.products!
                                          .where((fodpofdopfd) =>
                                              fodpofdopfd.productId ==
                                              'premium')
                                          .toList()
                                          .first,
                                    );
                                    if (donotv.error == null) {
                                      prDomAct.value = true;
                                      Pomo.pomo!.setBool('donpr', true);
                                    }

                                    prDonLo.value = false;
                                  }
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
                                  child: Obx(
                                    () => prDonLo.value
                                        ? CupertinoActivityIndicator()
                                        : Text(
                                            prDomAct.value
                                                ? 'premium activated'
                                                    .toUpperCase()
                                                : 'buy premium for\n0.99\$'
                                                    .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              height: 1.02,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Obx(
                                () => prDomAct.value
                                    ? SizedBox()
                                    : GestureDetector(
                                        onTap: () async {
                                          if (!puDonLo.value &&
                                              !prDomAct.value) {
                                            puDonLo.value = true;
                                            final ApphudComposite restPu =
                                                await Apphud.restorePurchases();

                                            bool failPu = true;

                                            if (restPu.purchases.isNotEmpty) {
                                              for (final pu
                                                  in restPu.purchases) {
                                                if (pu.productId == 'premium') {
                                                  prDomAct.value = true;
                                                  Pomo.pomo!
                                                      .setBool('donpr', true);
                                                  break;
                                                }
                                              }
                                            }

                                            if (failPu) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'Your purchase is not found'),
                                                ),
                                              );
                                            }

                                            puDonLo.value = false;
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 4),
                                          constraints:
                                              BoxConstraints(minHeight: 60),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/buttons/purple_btn.png'),
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: Obx(
                                            () => puDonLo.value
                                                ? CupertinoActivityIndicator()
                                                : Text(
                                                    'restore purchase'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
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
