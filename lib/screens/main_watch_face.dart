import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchtest/enum/TimerType.dart';
import 'package:watchtest/model/PaintingChange.dart';
import 'package:watchtest/model/TimerColor.dart';
import 'package:watchtest/widgets/stack_center_button.dart';
import 'package:get/get.dart';

import '../widgets/pie_timer_widget.dart';

class MainWatchFace extends StatelessWidget {
  final paintingChange = Get.put(PaintingChange());
  final timerColor = Get.put(TimerColor());
  MainWatchFace({Key? key}) : super(key: key);

  Future<void> getPaintStyle() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? flag = prefs.getString("paintStyle");

    if(flag == "fill") {
      paintingChange.paintingStyle = PaintingStyle.fill;
    } else {
      paintingChange.paintingStyle = PaintingStyle.stroke;
    }

  }

  Future<void> setTimerColors() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    timerColor.backTimerColor = prefs.getInt("backTimerColor") ?? 4292008703;
    timerColor.frontTimerColor = prefs.getInt("frontTimerColor") ?? 4289835775;
  }

  @override
  Widget build(BuildContext context) {
    getPaintStyle();
    setTimerColors();
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Obx(() {
              return PieTimerWidget(
                mediaHeight: MediaQuery.of(context).size.height,
                mediaWidth: MediaQuery.of(context).size.width,
                paintingStyle: paintingChange.paintingStyle,
                timerType: TimerType.none,
                backColor: timerColor.backTimerColor,
                frontColor: timerColor.frontTimerColor,
              );
            }),
            StackCenterButton(),
          ],
        ),
      ),
    );
  }
}
