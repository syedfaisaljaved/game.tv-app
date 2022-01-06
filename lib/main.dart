import 'package:flutter/material.dart';
import 'package:game_tv/ui/splash/splash_screen.dart';
import 'package:game_tv/utils/constants/color_const.dart';

import 'db/hive_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveProvider.initHive();
  await HiveProvider.openBox();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game.Tv',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: colorWhite,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
