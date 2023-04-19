import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchtest/model/TimerModel.dart';
import '../ui/pie_chart.dart';

class PieTimerWidget extends StatelessWidget {
  PieTimerWidget({required this.mediaWidth, required this.mediaHeight, required this.paintingStyle});
  final timerModel = Get.put(TimerModel());
  final double mediaWidth;
  final double mediaHeight;
  final PaintingStyle paintingStyle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Obx(() {
                return Container(
                  child: CustomPaint( // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                  size: Size(mediaWidth, mediaHeight), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                  painter: PieChart(timermin: timerModel.timerMin,
                    timersec: timerModel.timerSec,
                    totaltimer: timerModel.totalTimer,
                    currenttimer: timerModel.currentTimer,
                    paintingStyle: paintingStyle
                  ),
                  ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}