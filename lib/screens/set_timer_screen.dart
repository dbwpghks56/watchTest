import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:watchtest/model/PaintingChange.dart';
import 'package:watchtest/model/TimerModel.dart';

class SetTimerScreen extends StatelessWidget {
  final timerModel = Get.put(TimerModel());
  final paintingChange = Get.put(PaintingChange());
  SetTimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
            children: [
              TextButton(
                  onPressed: (){
                    timerModel.totalTimer = timerModel.timerMin * 60 + timerModel.timerSec;
                    timerModel.currentTimer = timerModel.totalTimer;

                    Get.back();
                  },
                  child: const Row(
                    children: [
                      Icon(
                          Icons.arrow_back
                      ),
                      Text("Back")
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 50,
                    child: Obx(() {
                      return TextField(
                        controller: TextEditingController(text: '${timerModel.timerMin}'),
                        decoration: const InputDecoration(border: InputBorder.none, ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          int min = int.parse(value);
                          if(min < 60 ) {
                            timerModel.timerMin = min;
                            timerModel.saveMin = min;
                          }
                        },
                      );
                    }),
                  ),
                  const Text(":"),
                  SizedBox(
                    width: 50,
                    child: Obx(() {
                      return TextField(
                        controller: TextEditingController(text: '${timerModel.timerSec}'),
                        decoration: const InputDecoration(border: InputBorder.none, ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          int sec = int.parse(value);
                          if (sec < 60) {
                            timerModel.timerSec = sec;
                            timerModel.saveSec = sec;
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),
                Obx(() {
                  return ListTile(
                    title: const Text('원형'),
                    leading: Radio<PaintingStyle>(
                      value: PaintingStyle.fill,
                      groupValue: paintingChange.paintingStyle,
                      onChanged: (PaintingStyle? value) {
                        paintingChange.paintingStyle = value;
                      },
                    ),
                  );
                }),
                Obx(() {
                  return ListTile(
                    title: const Text('선형'),
                    leading: Radio<PaintingStyle>(
                      value: PaintingStyle.stroke,
                      groupValue: paintingChange.paintingStyle,
                      onChanged: (PaintingStyle? value) {
                        paintingChange.paintingStyle = value;
                      },
                    ),
                  );
                }),
            ],
          )
      ),
    );
  }
}
