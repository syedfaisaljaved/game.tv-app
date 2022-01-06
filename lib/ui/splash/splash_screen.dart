import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_tv/db/hive_provider.dart';
import 'package:game_tv/ui/home/home_screen.dart';
import 'package:game_tv/ui/login/login_screen.dart';
import 'package:game_tv/utils/constants/color_const.dart';
import 'package:game_tv/utils/constants/img_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    if(HiveProvider.isLoggedIn)
      Timer(Duration(seconds: 1), navigateToHomeScreen);
    else
      Timer(Duration(seconds: 1), navigateToLoginScreen);
    super.initState();
  }

  navigateToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  navigateToLoginScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: colorWhite,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Image.asset(
          gameTvLogo,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width*0.7,
        ),
      ),
    );
  }
}
