import 'dart:ui';

import 'package:get/get.dart';

class RxPaintingChange {
  final paintingStyle = PaintingStyle.stroke.obs;
}

class PaintingChange {
  PaintingChange({timerMin, timerSec});

  final rx = RxPaintingChange();

  get paintingStyle => rx.paintingStyle.value;
  set paintingStyle(value) => rx.paintingStyle.value = value;
}