import 'package:flutter/material.dart';
import 'package:watchtest/screens/ambientwatchface.dart';
import 'package:watchtest/screens/main_timer_screen.dart';
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
  @override
  Widget build(BuildContext context) =>
      WatchShape(
        builder: (context, shape, child) =>
            InheritedShape(
              shape: shape,
              child: AmbientMode(
                builder: (context, mode, child) =>
                mode == WearMode.active ? MainWatchFace() : PieTimerWidget(mediaHeight: MediaQuery.of(context).size.height,
                  mediaWidth: MediaQuery.of(context).size.width,
                  paintingStyle: PaintingStyle.fill,
                ),
              ),
            ),
      );
}