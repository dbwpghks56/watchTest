import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RxTimerColor {
  final backTimerColor = 4292008703.obs;
  final frontTimerColor = 4289835775.obs;
}

class TimerColor {
  TimerColor({backTimerColor, frontTimerColor});

  final rx = RxTimerColor();

  get backTimerColor => rx.backTimerColor.value;
  set backTimerColor(value) => rx.backTimerColor.value = value;

  get frontTimerColor => rx.frontTimerColor.value;
  set frontTimerColor(value) => rx.frontTimerColor.value = value;
}