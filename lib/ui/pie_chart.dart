import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchtest/enum/TimerType.dart';

class PieChart extends CustomPainter {
  PieChart({ required this.timermin, required this.timersec, required this.totaltimer, required this.currenttimer, required this.paintingStyle, required this.timerType,
    required this.backTimerColor, required this.frontTimerColor});
  int timermin;
  int timersec;
  int totaltimer;
  int currenttimer;
  PaintingStyle paintingStyle;
  int backTimerColor;
  int frontTimerColor;
  TimerType timerType;

  double textScaleFactor = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint() // 화면에 그릴 때 쓸 Paint를 정의합니다.
    ..color = Color(backTimerColor!)
    ..strokeWidth = 10.0 // 선의 길이를 정합니다.
    ..style = paintingStyle // 선의 스타일을 정합니다. stroke면 외곽선만 그리고, fill이면 다 채웁니다.
    ..strokeCap = StrokeCap.round; // stroke의 스타일을 정합니다. round를 고르면 stroke의 끝이 둥글게 됩니다.

    double radius = min(size.width / 2 - paint.strokeWidth / 2 , size.height / 2 - paint.strokeWidth/2); // 원의 반지름을 구함. 선의 굵기에 영향을 받지 않게 보정함.
    if (paintingStyle == PaintingStyle.fill) {
      paint.color = Color(frontTimerColor!) ?? Colors.white38;
      radius = min(size.width / 2, size.height / 2);
    }
    Offset center = Offset(size.width / 2, size.height/ 2); // 원이 위젯의 가운데에 그려지게 좌표를 정함.

    canvas.drawCircle(center, radius, paint); // 원을 그림.

    double arcAngle = -(2 * pi * (((currenttimer / totaltimer - currenttimer) * 100) / 100)); // 호(arc)의 각도를 정함. 정해진 각도만큼만 그리도록 함.
    if(paintingStyle == PaintingStyle.stroke) {
      arcAngle = (2 * pi * (((currenttimer / totaltimer - currenttimer)) / (totaltimer-1)));
      paint.color = Color(frontTimerColor!) ?? Colors.white38; // 호를 그릴 때는 색을 바꿔줌.
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, paint); // 호(arc)를 그림.
    } else {
      Path p = Path()
        ..moveTo(size.width / 2, size.height / 2)
        ..arcTo(
            Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle,
            false)
        ..close();
      Paint paint2 = Paint()
        ..color = Color(backTimerColor!) ?? Colors.blueGrey;
      canvas.drawPath(p, paint2);
    }

    if(timerType == TimerType.lock) {
      drawText(canvas, size, "${timermin} : ${timersec}"); // 텍스트를 화면에 표시함.
    }
  }

  // 원의 중앙에 텍스트를 적음.
  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      shadows: const [
        Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 2.0,
          color: Colors.black,
        ),
      ],
    ), text: text); // TextSpan은 Text위젯과 거의 동일하다.
    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

    tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  // 화면 크기에 비례하도록 텍스트 폰트 크기를 정함.
  double getFontSize(Size size, String text) {
    return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PieChart oldDelegate) {
    return oldDelegate.currenttimer != currenttimer;
  }
}