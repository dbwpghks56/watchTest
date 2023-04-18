import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchtest/model/TimerModel.dart';
import 'package:sprintf/sprintf.dart';
import 'package:watchtest/screens/set_timer_screen.dart';
import 'package:wear/wear.dart';

import '../enum/TimerStatus.dart';

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
    timerModel.timerStatus = TimerStatus.stopped;
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
          timerModel.timerMin = timerModel.saveMin;
          timerModel.timerSec = timerModel.saveSec;
          t.cancel();
          break;
        case TimerStatus.running:
          if(timerModel.timerSec <= 0 && timerModel.timerMin <= 0) {
            timerModel.timerStatus = TimerStatus.stopped;
            t.cancel();
          } else {
            timerModel.timerSec -= 1;
            if(timerModel.timerSec <= 0 && timerModel.timerMin > 0) {
              timerModel.timerMin -= 1;
              timerModel.timerSec = 59;
            }
          }
          break;
        case TimerStatus.resting:
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
                    _SizedButton(
                        content: "정지",
                        onButtonPressed: () {
                          stop();
                        }
                    ),
                    _SizedButton(
                        content: "시작",
                        onButtonPressed: () {
                          run();
                        }
                    ),
                    _SizedButton(
                        content: "리셋",
                        onButtonPressed: () {
                          reset();
                        }
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.all(5)),
                _SizedButton(
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

class _SizedButton extends StatelessWidget {
  final String content;
  final GestureTapCallback onButtonPressed;

  const _SizedButton({
    required this.content,
    required this.onButtonPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27,
      width: 50,
      child: ElevatedButton(
        onPressed: onButtonPressed,
        child: Text(content,
          style: const TextStyle(fontSize: 8),
        ),
      ),
    );
  }
}
