import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';
import 'package:watchtest/model/PaintingChange.dart';
import 'package:watchtest/model/TimerColor.dart';
import 'package:watchtest/model/TimerModel.dart';
import 'package:watchtest/screens/set_timer_screen.dart';
import 'package:watchtest/ui/sized_button.dart';

import '../enum/TimerStatus.dart';

class StackCenterButton extends StatelessWidget {
  final timerModel = Get.put(TimerModel());
  final paintingChange = Get.put(PaintingChange());
  StackCenterButton({Key? key}) : super(key: key);

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
          timerModel.timerStatus = TimerStatus.stopped;
          break;
        default: break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return Text(
                timerToString(timerModel.timerMin, timerModel.timerSec),
                style: TextStyle(
                  fontSize: 40,
                  color: paintingChange.paintingStyle == PaintingStyle.stroke ? Colors.black : Colors.white,
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.blue
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(2),
                      onTap: () {
                        Get.to(() => SetTimerScreen());
                      },
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 15,
                      ),
                    )
                ),
                const Padding(padding: EdgeInsets.only(right: 8)),
                ClipOval(
                  child: Material(
                    color: Colors.blue, // button color
                    child: Obx(() {
                      return InkWell(// inkwell color
                        child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              timerModel.timerStatus != TimerStatus.running ? Icons.play_arrow : Icons.stop,
                              size: 50,
                              color: Colors.white,
                            )
                        ),
                        onTap: () {
                          if(timerModel.timerStatus == TimerStatus.running) {
                            stop();
                          }
                          else if(timerModel.timerStatus == TimerStatus.stopped || timerModel.timerStatus == TimerStatus.resting) {
                            run();
                          }
                        },
                      );
                    })
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 8)),
                Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.blue
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(2),
                      onTap: () {
                        reset();
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 15,
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      );
  }
}
