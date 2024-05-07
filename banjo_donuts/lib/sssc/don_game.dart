import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:banjo_donuts/hern/pomo.dart';
import 'package:banjo_donuts/hern/zvuki.dart';
import 'package:banjo_donuts/sssc/don_scr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DonGame extends StatefulWidget {
  final int seconds;
  const DonGame({required this.seconds, super.key});

  @override
  State<DonGame> createState() => _DonGameState();
}

class _DonGameState extends State<DonGame> with TickerProviderStateMixin {
  late final RxInt _lastSec = widget.seconds.obs;
  late Timer _donTimer;

  late final _oranBotController = AnimationController(vsync: this);
  late final _pinkBotController = AnimationController(vsync: this);
  late final _purpBotController = AnimationController(vsync: this);
  late final _pinkController = AnimationController(vsync: this);
  late final _yellowController = AnimationController(vsync: this);

  final RxDouble _firstHeight = 206.0.obs;
  final RxDouble _secondHeight = 184.0.obs;
  final RxDouble _thirdHeight = 146.0.obs;
  final RxDouble _firstWidth = 194.0.obs;
  final RxDouble _secondWidth = 172.0.obs;
  final RxDouble _thirdWidth = 137.0.obs;
  late final RxDouble _firstLeft = 10000.0.obs;
  late final RxDouble _secondLeft = (_secondWidth.value - 20).obs;
  late final RxDouble _thirdLeft = (_firstWidth.value).obs;
  var _rand = Random();
  var _thinkCol = '';
  var _thinkPosip = '';
  var _curCol = '';
  var _curPosip = '';

  final List<String> _donQueue = ['ham', 'dog', 'cat'];
  RxInt donScore = 0.obs;
  RxInt donLifes = (Pomo.pomo!.getBool('donpr') ?? false ? 4 : 3).obs;

  bool _animateLast = false;
  bool _isAngry = false;
  bool _donPause = false;

  String generateColor() {
    int colRand = _rand.nextInt(3);
    if (colRand == 0) {
      return '_pink';
    } else if (colRand == 1) {
      return '_purp';
    } else {
      return '_oran';
    }
  }

  String generatePosip() {
    int colRand = _rand.nextInt(3);
    if (colRand == 0) {
      return '_blue';
    } else if (colRand == 1) {
      return '_white';
    } else {
      return '';
    }
  }

  void startDonTimer() {
    _donTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_donPause) {
        _lastSec.value--;
      }
      if (_lastSec.value == 0) {
        _donTimer.cancel();
        _wilo();
      }
    });
  }

  Widget _getDonAnim(int indexDon, String assetDon) => Obx(
        () => indexDon == 2 && _animateLast
            ? Positioned(
                top: ((Get.height) / 5) * 3 - _firstHeight.value - 18,
                left: _firstLeft.value == 10000
                    ? null
                    : Get.width / 2 - _firstLeft.value,
                child: AnimatedContainer(
                  duration: 200.ms,
                  height: _firstHeight.value,
                  width: _firstWidth.value,
                  child: Image.asset(
                    _isAngry
                        ? 'assets/game/angry_$assetDon.png'
                        : 'assets/game/happy_$assetDon.png',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              )
                .animate()
                .move(
                    delay: 200.ms,
                    duration: Duration(milliseconds: 150),
                    begin: Offset.zero,
                    end: Offset(0, -20))
                .move(
                    delay: 150.ms,
                    duration: Duration(milliseconds: 300),
                    begin: Offset.zero,
                    end: Offset(0, 320))
            : AnimatedPositioned(
                duration: 200.ms,
                top: indexDon == 0
                    ? ((Get.height) / 5) * 3 - _thirdHeight.value - 18
                    : indexDon == 1
                        ? ((Get.height) / 5) * 3 - _secondHeight.value - 18
                        : ((Get.height) / 5) * 3 - _firstHeight.value - 18,
                left: indexDon == 0
                    ? Get.width / 2 - _thirdLeft.value
                    : indexDon == 1
                        ? Get.width / 2 - _secondLeft.value
                        : null,
                child: AnimatedContainer(
                  duration: 200.ms,
                  height: indexDon == 0
                      ? _thirdHeight.value
                      : indexDon == 1
                          ? _secondHeight.value
                          : _firstHeight.value,
                  width: indexDon == 0
                      ? _thirdWidth.value
                      : indexDon == 1
                          ? _secondWidth.value
                          : _firstWidth.value,
                  child: Image.asset(
                    'assets/game/$assetDon.png',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
      );

  @override
  void initState() {
    _thinkCol = generateColor();
    _thinkPosip = generatePosip();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startDonTimer();
    });
  }

  void donEvent(bool addPosip, String donName) async {
    if (addPosip) {
      if (_curCol.isEmpty) {
        return;
      }
      _curPosip = donName;
      if (_thinkCol != _curCol || _thinkPosip != _curPosip) {
        _isAngry = true;
        donLifes.value--;
      } else {
        donScore.value += 100;
      }
      setState(() {});
      _jumpOut();
    } else {
      _curCol = donName;
      if (_thinkPosip.isEmpty) {
        if (_thinkCol != _curCol) {
          _isAngry = true;
          donLifes.value--;
        } else {
          donScore.value += 100;
        }
        _jumpOut();
      }
      setState(() {});
    }
    await Future.delayed(500.ms);
    if (donLifes < 1) {
      _donTimer.cancel();
      _wilo();
    }
  }

  void _jumpOut() async {
    _animateLast = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 450));
    _animateLast = false;
    setState(() {});
    _donQueue.removeLast();
    int nextRandDon = _rand.nextInt(3);
    _donQueue.insert(
      0,
      nextRandDon == 0
          ? 'ham'
          : nextRandDon == 1
              ? 'dog'
              : 'cat',
    );
    _isAngry = false;
    _thinkCol = generateColor();
    _thinkPosip = generatePosip();
    _curCol = '';
    _curPosip = '';
    setState(() {});
    // _thirdLeft.value = _secondLeft.value;
    // _thirdHeight.value = _secondHeight.value;
    // _thirdWidth.value = _secondWidth.value;
    // _secondLeft.value = _firstLeft.value;
    // _secondHeight.value = _firstHeight.value;
    // _secondWidth.value = _firstWidth.value;
  }

  @override
  void dispose() {
    super.dispose();
    _donTimer.cancel();
  }

  void _donAgain() {
    _thinkCol = generateColor();
    _thinkPosip = generatePosip();
    _curCol = '';
    _curPosip = '';
    _donQueue.clear();
    int nextRandDon = _rand.nextInt(3);
    _donQueue.insert(
      0,
      nextRandDon == 0
          ? 'ham'
          : nextRandDon == 1
              ? 'dog'
              : 'cat',
    );
    nextRandDon = _rand.nextInt(3);
    _donQueue.insert(
      0,
      nextRandDon == 0
          ? 'ham'
          : nextRandDon == 1
              ? 'dog'
              : 'cat',
    );
    nextRandDon = _rand.nextInt(3);
    _donQueue.insert(
      0,
      nextRandDon == 0
          ? 'ham'
          : nextRandDon == 1
              ? 'dog'
              : 'cat',
    );
    donScore.value = 0;
    donLifes.value = (Pomo.pomo!.getBool('donpr') ?? false ? 4 : 3);

    _animateLast = false;
    _isAngry = false;
    _donPause = false;
    _donTimer.cancel();
    _lastSec.value = widget.seconds;
    setState(() {});
    startDonTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(147, 223, 255, 1),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/game/kitchen.png',
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            width: Get.width,
            height: Get.height,
          ),
          ...List.generate(
            3,
            (donInd) => _getDonAnim(
              donInd,
              _donQueue[donInd],
            ),
          ),
          Positioned(
            top: ((Get.height) / 5) * 3 - _firstHeight.value - 8 - 90,
            child: AnimatedOpacity(
              duration: 200.ms,
              opacity: !_animateLast ? 1 : 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/game/dialog.png',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                    width: 183,
                    height: 133,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 29),
                    child: Image.asset(
                      'assets/game/don$_thinkCol$_thinkPosip.png',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      width: 78,
                      height: 58,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: ((Get.height) / 5) * 3 - 18,
            child: Image.asset(
              'assets/game/table.png',
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              width: Get.width,
              height: (Get.height / 5) * 2 + 18,
            ),
          ),
          Positioned(
            top: ((Get.height) / 5) * 3 - 12,
            child: Image.asset(
              'assets/game/plate.png',
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              width: 194,
              height: 75,
            ),
          ),
          Positioned(
            top: ((Get.height) / 5) * 3 - 20,
            child: Image.asset(
              'assets/game/don$_curCol$_curPosip.png',
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              width: 104,
              height: 75,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 54),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (!_oranBotController.isAnimating) {
                        _oranBotController.forward();
                        Zvuki.musDonOne('bottle.mp3');
                        await Future.delayed(500.ms);
                        donEvent(false, '_oran');
                      }
                    },
                    child: Image.asset(
                      'assets/game/oran_bottle.png',
                      filterQuality: FilterQuality.high,
                      height: 166,
                    ).animate(
                      autoPlay: false,
                      controller: _oranBotController,
                      onComplete: (controller) {
                        controller.reverse();
                      },
                    )
                      ..rotate(
                        duration: Duration(milliseconds: 250),
                        begin: 0,
                        end: 3.1415 / 16,
                      )
                      ..move(
                        duration: Duration(milliseconds: 250),
                        begin: Offset(0, 0),
                        end: Offset(0, -200),
                      ),
                  ),
                  SizedBox(
                    width: 21,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!_pinkBotController.isAnimating) {
                        _pinkBotController.forward();
                        Zvuki.musDonOne('bottle.mp3');
                        await Future.delayed(500.ms);
                        donEvent(false, '_pink');
                      }
                    },
                    child: Image.asset(
                      'assets/game/pink_bottle.png',
                      filterQuality: FilterQuality.high,
                      height: 166,
                    ).animate(
                      autoPlay: false,
                      controller: _pinkBotController,
                      onComplete: (controller) {
                        controller.reverse();
                      },
                    )
                      ..rotate(
                        duration: Duration(milliseconds: 250),
                        begin: 0,
                        end: 3.1415 / 16,
                      )
                      ..move(
                        duration: Duration(milliseconds: 250),
                        begin: Offset(0, 0),
                        end: Offset(0, -200),
                      ),
                  ),
                  SizedBox(
                    width: 21,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!_purpBotController.isAnimating) {
                        _purpBotController.forward();
                        Zvuki.musDonOne('bottle.mp3');
                        await Future.delayed(500.ms);
                        donEvent(false, '_purp');
                      }
                    },
                    child: Image.asset(
                      'assets/game/purp_bottle.png',
                      filterQuality: FilterQuality.high,
                      height: 166,
                    ).animate(
                      autoPlay: false,
                      controller: _purpBotController,
                      onComplete: (controller) {
                        controller.reverse();
                      },
                    )
                      ..rotate(
                        duration: Duration(milliseconds: 250),
                        begin: 0,
                        end: 3.1415 / 16,
                      )
                      ..move(
                        duration: Duration(milliseconds: 250),
                        begin: Offset(0, 0),
                        end: Offset(0, -200),
                      ),
                  ),
                  SizedBox(
                    width: 26,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!_pinkController.isAnimating && _curCol.isNotEmpty) {
                        _pinkController.forward();
                        Zvuki.musDonOne('banka.mp3');
                        await Future.delayed(500.ms);
                        donEvent(true, '_white');
                      }
                    },
                    child: AnimatedOpacity(
                      duration: 50.ms,
                      opacity: _curCol.isNotEmpty ? 1 : 0.5,
                      child: Image.asset(
                        'assets/game/white.png',
                        filterQuality: FilterQuality.high,
                        height: 108,
                      ).animate(
                        controller: _pinkController,
                        autoPlay: false,
                        onComplete: (controller) {
                          controller.reset();
                          setState(() {});
                        },
                      )
                        ..move(
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(0, -30),
                        )
                        ..move(
                          delay: 50.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(10, 0),
                        )
                        ..move(
                          delay: 100.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(-10, 0),
                        )
                        ..move(
                          delay: 150.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(-10, 0),
                        )
                        ..move(
                          delay: 200.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(10, 0),
                        )
                        ..move(
                          delay: 250.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(0, 30),
                        ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!_yellowController.isAnimating &&
                          _curCol.isNotEmpty) {
                        _yellowController.forward();
                        Zvuki.musDonOne('banka.mp3');
                        await Future.delayed(500.ms);
                        donEvent(true, '_blue');
                      }
                    },
                    child: AnimatedOpacity(
                      duration: 50.ms,
                      opacity: _curCol.isNotEmpty ? 1 : 0.5,
                      child: Image.asset(
                        'assets/game/blue.png',
                        filterQuality: FilterQuality.high,
                        height: 108,
                      ).animate(
                        controller: _yellowController,
                        autoPlay: false,
                        onComplete: (controller) {
                          controller.reset();
                        },
                      )
                        ..move(
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(0, -30),
                        )
                        ..move(
                          delay: 50.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(10, 0),
                        )
                        ..move(
                          delay: 100.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(-10, 0),
                        )
                        ..move(
                          delay: 150.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(-10, 0),
                        )
                        ..move(
                          delay: 200.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(10, 0),
                        )
                        ..move(
                          delay: 250.ms,
                          duration: Duration(milliseconds: 50),
                          begin: Offset.zero,
                          end: Offset(0, 30),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              left: 14,
              right: 14,
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Obx(
                            () => Text(
                              '0${_lastSec ~/ 60}:${_lastSec % 60 < 10 ? '0${_lastSec % 60}' : _lastSec % 60}'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(0, 2),
                                    blurRadius: 0,
                                    color: Color.fromRGBO(35, 50, 100, 0.5),
                                  ),
                                  Shadow(
                                      offset: Offset(-1, -1),
                                      color: Color.fromRGBO(0, 23, 105, 1)),
                                  Shadow(
                                      offset: Offset(1, -1),
                                      color: Color.fromRGBO(0, 23, 105, 1)),
                                  Shadow(
                                      offset: Offset(1, 1),
                                      color: Color.fromRGBO(0, 23, 105, 1)),
                                  Shadow(
                                      offset: Offset(-1, 1),
                                      color: Color.fromRGBO(0, 23, 105, 1)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: IntrinsicHeight(
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 42,
                              minWidth: 120,
                            ),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/buttons/score.png'),
                                filterQuality: FilterQuality.high,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.only(bottom: 6),
                            alignment: Alignment.center,
                            child: Obx(
                              () => Text(
                                NumberFormat.decimalPattern()
                                    .format(donScore.value)
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(0, 2),
                                      blurRadius: 0,
                                      color: Color.fromRGBO(35, 50, 100, 0.5),
                                    ),
                                    Shadow(
                                        offset: Offset(-1, -1),
                                        color: Color.fromRGBO(0, 23, 105, 1)),
                                    Shadow(
                                        offset: Offset(1, -1),
                                        color: Color.fromRGBO(0, 23, 105, 1)),
                                    Shadow(
                                        offset: Offset(1, 1),
                                        color: Color.fromRGBO(0, 23, 105, 1)),
                                    Shadow(
                                        offset: Offset(-1, 1),
                                        color: Color.fromRGBO(0, 23, 105, 1)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              _donPause = true;
                              _pupe();
                            },
                            child: Image.asset(
                              'assets/buttons/menu_btn.png',
                              height: 48,
                              width: 48,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Image.asset(
                        donLifes.value < 1
                            ? 'assets/game/empty_hrt.png'
                            : 'assets/game/hrt.png',
                        height: 28,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Obx(
                      () => Image.asset(
                        donLifes.value < 2
                            ? 'assets/game/empty_hrt.png'
                            : 'assets/game/hrt.png',
                        height: 28,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Obx(
                      () => Image.asset(
                        donLifes.value < 3
                            ? 'assets/game/empty_hrt.png'
                            : 'assets/game/hrt.png',
                        height: 28,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    if (Pomo.pomo!.getBool('donpr') ?? false)
                      SizedBox(
                        width: 16,
                      ),
                    if (Pomo.pomo!.getBool('donpr') ?? false)
                      Obx(
                        () => Image.asset(
                          donLifes.value < 4
                              ? 'assets/game/empty_hrt.png'
                              : 'assets/game/hrt.png',
                          height: 28,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _wilo() {
    final donCurScore = Pomo.pomo!.getInt('${widget.seconds}_score') ?? 0;
    if (donScore.value > donCurScore) {
      Pomo.pomo!.setInt('${widget.seconds}_score', donScore.value);
      Pomo.pomo!.setString('${widget.seconds}_date',
          DateFormat('dd.MM.yyyy').format(DateTime.now()).toString());
    }
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/game/happy_dog.png',
                            filterQuality: FilterQuality.high,
                            width: 144,
                          ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'your score: ${donScore.value}'
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
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
                                            Get.back();
                                            _donAgain();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4),
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
                                            child: Text(
                                              'retry'.toUpperCase(),
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
                                            Get.offAll(() => DonScr());
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4),
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
                                            child: Text(
                                              'exit'.toUpperCase(),
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
                              ],
                            ),
                          ),
                          Opacity(
                            opacity: 0,
                            child: Image.asset(
                              'assets/game/happy_cat.png',
                              filterQuality: FilterQuality.high,
                              width: 144,
                            ),
                          ),
                        ],
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

  void _pupe() {
    final RxBool musDan = (Pomo.pomo!.getBool('donms') ?? true).obs;
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 24),
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
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/game/happy_cat.png',
                            filterQuality: FilterQuality.high,
                            width: 144,
                          ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'pause'.toUpperCase(),
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
                                            Get.back();
                                            _donAgain();
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4),
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
                                            child: Text(
                                              'retry'.toUpperCase(),
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
                                            Get.offAll(() => DonScr());
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4),
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
                                            child: Text(
                                              'exit'.toUpperCase(),
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
                          Opacity(
                            opacity: 0,
                            child: Image.asset(
                              'assets/game/happy_cat.png',
                              filterQuality: FilterQuality.high,
                              width: 144,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).then((value) {
      _donPause = false;
    });
  }
}
