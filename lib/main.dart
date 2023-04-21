import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchtest/enum/TimerType.dart';
import 'package:watchtest/model/TimerColor.dart';
import 'package:watchtest/screens/main_watch_face.dart';
import 'package:watchtest/widgets/pie_timer_widget.dart';
import 'package:wear/wear.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Flutter Wear App',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: WatchScreen(),
    debugShowCheckedModeBanner: false,
  );
}

class WatchScreen extends StatelessWidget {
  final timerColor = Get.put(TimerColor());

  Future<void> setTimerColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    timerColor.backTimerColor = prefs.getInt("backTimerColor") ?? 4292008703;
    timerColor.frontTimerColor = prefs.getInt("frontTimerColor") ?? 4289835775;
  }

  @override
  Widget build(BuildContext context) {
    setTimerColors();
    return WatchShape(
      builder: (context, shape, child) =>
          InheritedShape(
            shape: shape,
            child: AmbientMode(
              builder: (context, mode, child) =>
              mode == WearMode.active ? MainWatchFace() : PieTimerWidget(
                mediaHeight: MediaQuery
                    .of(context)
                    .size
                    .height,
                mediaWidth: MediaQuery
                    .of(context)
                    .size
                    .width,
                paintingStyle: PaintingStyle.fill,
                timerType: TimerType.lock,
                backColor: timerColor.backTimerColor,
                frontColor: timerColor.frontTimerColor,
              ),
            ),
          ),
    );
  }
}