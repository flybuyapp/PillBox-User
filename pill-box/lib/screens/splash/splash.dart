import 'dart:async';
import 'dart:developer';

import 'package:flybuy/constants/assets.dart';
import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/constants/splash.dart';
import 'package:flybuy/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:ui/painter/zoom_painter.dart';

import '../home/home.dart';
import 'widgets/zoom_animation.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  const SplashScreen({super.key, this.loading});

  final bool? loading;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Size size = Size.zero;
  late AnimationController _controller;
  late ZoomAnimation _animation;
  AnimationStatus _status = AnimationStatus.forward;

  @override
  void initState() {
    super.initState();
    //NGD
    startTime();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 7000),
      vsync: this,
    )
      ..addStatusListener((AnimationStatus status) {
        log('AnimationStatus ::: $status');
        setState(() {
          _status = status;
        });
      })
      ..addListener(() {
        setState(() {});
      });
    _animation = ZoomAnimation(_controller);
  }

  @override
  void didChangeDependencies() {
    setState(() {
      size = MediaQuery.of(context).size;
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SplashScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading!=null&& !widget.loading! && _controller.status != AnimationStatus.forward) {
      _controller.forward();

    }
  }

  @override
  Widget build(BuildContext context) {
    log('AnimationStatus ::: ${_controller.reverseDuration}');
    if (_status == AnimationStatus.completed) return Container();
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: ZoomPainter(
              color: ConvertData.fromHex(splashScreenColor, Colors.white) ??
                  Colors.white,
              zoomSize: _animation.zoomSize.value * size.width,
            ),
          ),
        ),
        if (splashScreenType == 'full')
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: _animation.textOpacity.value,
              child: Image.asset(
                Assets.splash,
                width: double.infinity,
                height: double.infinity,
                fit: ConvertData.toBoxFit(splashScreenBoxFit),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(bottom: itemPaddingExtraLarge),
            child: Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: _animation.textOpacity.value,
                child: Image.asset(
                  Assets.logo,
                  width: splashScreenLogoWidth,
                  height: splashScreenLogoHeight,
                  fit: ConvertData.toBoxFit(splashScreenBoxFit),
                ),
              ),
            ),
          )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  //NGD
  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }
  //NGD
  void navigationPage() {
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}
