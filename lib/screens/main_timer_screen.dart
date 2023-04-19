import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchtest/model/TimerModel.dart';
import 'package:sprintf/sprintf.dart';
import 'package:watchtest/screens/set_timer_screen.dart';
import 'package:wear/wear.dart';

import '../enum/TimerStatus.dart';
import '../ui/sized_button.dart';
import '../widgets/pie_timer_widget.dart';

class MainTimerScreen extends StatelessWidget {
  final timerModel = Get.put(TimerModel());

  String timerToString(int min, int sec) {
    return sprintf("%02d:%02d", [min, sec]);
  }

  void run() {
    timerModel.timerStatus = TimerStatus.running;
    runTimer();
  }

  void reset() {
    timerModel.timerStatus = TimerStatus.resting;
  }

  void pause() {
      timerModel.timerStatus = TimerStatus.paused;
  }

  void resume() {
    run();
  }

  void stop() {
    timerModel.timerStatus = TimerStatus.stopped;
  }

  void runTimer() async {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      switch(timerModel.timerStatus) {
        case TimerStatus.paused: t.cancel(); break;
        case TimerStatus.stopped:
          t.cancel();
          break;
        case TimerStatus.running:

          if(timerModel.timerSec <= 0 && timerModel.timerMin <= 0) {
            timerModel.timerStatus = TimerStatus.stopped;
            timerModel.timerMin = timerModel.saveMin;
            timerModel.timerSec = timerModel.saveSec;
            timerModel.currentTimer = timerModel.totalTimer;
            t.cancel();
          } else {
            timerModel.timerSec -= 1;
            timerModel.currentTimer -= 1;
            if(timerModel.timerSec <= 0 && timerModel.timerMin > 0) {
              timerModel.timerMin -= 1;
              timerModel.timerSec = 59;
            }
          }
          break;
        case TimerStatus.resting:
          timerModel.timerMin = timerModel.saveMin;
          timerModel.timerSec = timerModel.saveSec;
          timerModel.currentTimer = timerModel.totalTimer;
          t.cancel();
          break;
        default: break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: WatchShape(
          builder: (context, shape, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Obx(() {
                  return Text(
                    timerToString(timerModel.timerMin, timerModel.timerSec),
                    style: const TextStyle(
                        fontSize: 50
                    ),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedButton(
                        boxWidth: 50,
                        boxHeight: 27,
                        content: "정지",
                        onButtonPressed: () {
                          stop();
                        }
                    ),
                    SizedButton(
                        boxWidth: 50,
                        boxHeight: 27,
                        content: "시작",
                        onButtonPressed: () {
                          run();
                        }
                    ),
                    SizedButton(
                        boxWidth: 50,
                        boxHeight: 27,
                        content: "리셋",
                        onButtonPressed: () {
                          reset();
                        }
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(5)),
                SizedButton(
                    boxWidth: 50,
                    boxHeight: 27,
                    content: "설정",
                    onButtonPressed: () {
                      Get.to(() => SetTimerScreen());
                    }
                ),
                child!,
              ],
            );
          },
          child: AmbientMode(
            builder: (BuildContext context, WearMode mode, Widget? child) {
              return Container();
            },
          ),
        ),
      ),
    );
  }
}


