import 'package:get/get.dart';
import 'package:watchtest/enum/TimerStatus.dart';

class RxTimerModel {
  final timerMin = 0.obs;
  final timerSec = 0.obs;
  final saveSec = 0.obs;
  final saveMin = 0.obs;
  final totalTimer = 0.obs;
  final currentTimer = 0.obs;
  final timerStatus = TimerStatus.stopped.obs;
}

class TimerModel {
  TimerModel({timerMin, timerSec});

  final rx = RxTimerModel();

  get timerMin => rx.timerMin.value;
  set timerMin(value) => rx.timerMin.value = value;

  get totalTimer => rx.totalTimer.value;
  set totalTimer(value) => rx.totalTimer.value = value;

  get currentTimer => rx.currentTimer.value;
  set currentTimer(value) => rx.currentTimer.value = value;

  get timerSec => rx.timerSec.value;
  set timerSec(value) => rx.timerSec.value = value;

  get saveSec => rx.saveSec.value;
  set saveSec(value) => rx.saveSec.value = value;

  get saveMin => rx.saveMin.value;
  set saveMin(value) => rx.saveMin.value = value;

  get timerStatus => rx.timerStatus.value;
  set timerStatus(value) => rx.timerStatus.value = value;
}
