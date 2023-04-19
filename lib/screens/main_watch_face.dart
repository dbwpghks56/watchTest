import 'package:flutter/material.dart';
import 'package:watchtest/widgets/stack_center_button.dart';

import '../widgets/pie_timer_widget.dart';

class MainWatchFace extends StatelessWidget {
  const MainWatchFace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            PieTimerWidget(
              mediaHeight: MediaQuery.of(context).size.height,
              mediaWidth: MediaQuery.of(context).size.width,
              paintingStyle: PaintingStyle.stroke
            ),
            StackCenterButton(),
          ],
        ),
      ),
    );
  }
}
