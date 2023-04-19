import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchtest/model/TimerModel.dart';
import '../ui/pie_chart.dart';

class PieTimerWidget extends StatelessWidget {
  final timerModel = Get.put(TimerModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Obx(() {
                return Container(
                  child: CustomPaint( // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                  size: Size(150, 150), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                  painter: PieChart(timermin: timerModel.timerMin, timersec: timerModel.timerSec, totaltimer: timerModel.totalTimer, currenttimer: timerModel.currentTimer),
                  ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}