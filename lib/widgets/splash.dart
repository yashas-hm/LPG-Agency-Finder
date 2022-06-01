import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lpg_agency_finder/screens/user_data.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _tween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2700));
    _tween =
        Tween<double>(begin: 0.0, end: 150.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    _animationController.forward();
    _animationController.addListener(() {
      if (_tween.isCompleted) {
        Timer(
            const Duration(milliseconds: 500),
            () => Navigator.of(context)
                .pushReplacementNamed(UserDataScreen.routeName));
      }
    });

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
        ),
        AnimatedBuilder(
          animation: _tween,
          builder: (ctx, child) => Center(
            child: Container(
              color: Colors.redAccent,
              width: 150,
              height: _tween.value,
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset(
              !darkMode ? 'assets/gas_light.png' : 'assets/gas_dark.png',
            ),
          ),
        ),
      ],
    );
  }
}
