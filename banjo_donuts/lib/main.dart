import 'package:apphud/apphud.dart';
import 'package:banjo_donuts/hern/pomo.dart';
import 'package:banjo_donuts/sssc/don_scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Pomo.poooo();
  await Apphud.start(apiKey: 'app_Srxuhpmvr4gMKqLfDH7Gf1uxEatAXo');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyAppDonuts());
}

class MyAppDonuts extends StatelessWidget {
  const MyAppDonuts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Banjo Donuts',
      theme: ThemeData(
        fontFamily: 'Titan',
        useMaterial3: true,
      ),
      home: MediaQuery.withNoTextScaling(child: const DonScr()),
    );
  }
}
