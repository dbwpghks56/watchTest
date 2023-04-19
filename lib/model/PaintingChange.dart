import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RxPaintingChange {
  final paintingStyle = PaintingStyle.stroke.obs;
}

class PaintingChange {
  PaintingChange({timerMin, timerSec});

  final rx = RxPaintingChange();

  get paintingStyle => rx.paintingStyle.value;
  set paintingStyle(value) => rx.paintingStyle.value = value;
}