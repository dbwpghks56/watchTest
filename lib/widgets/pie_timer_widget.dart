import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchtest/enum/TimerType.dart';
import 'package:watchtest/model/TimerColor.dart';
import 'package:watchtest/model/TimerModel.dart';
import '../ui/pie_chart.dart';

class PieTimerWidget extends StatelessWidget {
  PieTimerWidget({required this.mediaWidth, required this.mediaHeight, required this.paintingStyle, required this.timerType, this.backColor, this.frontColor});
  final timerModel = Get.put(TimerModel());
  final timerColor = Get.put(TimerColor());
  final double mediaWidth;
  final double mediaHeight;
  final int? backColor;
  final int? frontColor;
  final PaintingStyle paintingStyle;
  final TimerType timerType;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  child:
                  Obx(() {
                    return CustomPaint( // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                      size: Size(mediaWidth, mediaHeight), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                      painter:
                      PieChart(
                          timermin: timerModel.timerMin,
                          timersec: timerModel.timerSec,
                          totaltimer: timerModel.totalTimer,
                          currenttimer: timerModel.currentTimer,
                          paintingStyle: paintingStyle,
                          timerType: timerType,
                          backTimerColor: backColor!,
                          frontTimerColor: frontColor!
                      ),
                    );
                  })
              )
            ],
          ),
        ),
      ),
    );
  }
}