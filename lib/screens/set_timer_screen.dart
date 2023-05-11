
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchtest/model/PaintingChange.dart';
import 'package:watchtest/model/TimerColor.dart';
import 'package:watchtest/model/TimerModel.dart';

class SetTimerScreen extends StatelessWidget {
  final timerModel = Get.put(TimerModel());
  final paintingChange = Get.put(PaintingChange());
  final timerColor = Get.put(TimerColor());
  final List<bool> _timerType = <bool>[false, false];
  SetTimerScreen({Key? key}) : super(key: key);

  Future<SharedPreferences> getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> setPaintingType(String paintingStyle) async {
    getPrefs().then((value) => value.setString("paintStyle", paintingStyle));
  }

  Future<void> setBackTimerColor(int colorCode) async {
    getPrefs().then((value) => value.setInt("backTimerColor", colorCode));
  }

  Future<void> setFrontTimerColor(int colorCode) async {
    getPrefs().then((value) => value.setInt("frontTimerColor", colorCode));
  }

  @override
  Widget build(BuildContext context) {
    var colorList = [const Color(0xff284FFF),const Color(0xffFFFFFF),const Color(0xff1A1A1A),const Color(0xffB1B2FF), const Color(0xffAAC4FF), const Color(0xffD2DAFF), const Color(0xffEEF1FF),
      const Color(0xffFFF2CC), const Color(0xffFFD966), const Color(0xffF4B183), const Color(0xffDFA67B)];
    var colorListFront = [const Color(0xffFF44A1),const Color(0xffFF2828),const Color(0xff28FFC6),const Color(0xffB1B2FF), const Color(0xffAAC4FF), const Color(0xffD2DAFF), const Color(0xffEEF1FF),
      const Color(0xffFFF2CC), const Color(0xffFFD966), const Color(0xffF4B183), const Color(0xffDFA67B)];
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
                  child: Row(
                    children: const [
                      Icon(
                          Icons.arrow_back,
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
                        setPaintingType("fill");
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
                        setPaintingType("stroke");
                        paintingChange.paintingStyle = value;
                      },
                    ),
                  );
                }),
                ElevatedButton(
                    onPressed: (){
                      Get.dialog(
                        Dialog(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.count(
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              crossAxisCount: 2,
                              // Generate 100 widgets that display their index in the List.
                              children: List.generate(colorList.length, (index) {
                                return Center(
                                    child: Container(
                                      color: colorList[index],
                                      child: Obx(() {
                                        return InkWell(
                                          onTap: () async {
                                            await setBackTimerColor(colorList[index].value);
                                            timerColor.backTimerColor = colorList[index].value;
                                            Get.back();
                                          },
                                          focusColor: Color(timerColor.backTimerColor),
                                        );
                                      })
                                    )
                                );
                              }),
                            ),
                          ),
                        )
                      );
                    },
                    child: const Text("배경 색")
                ),
              ElevatedButton(
                  onPressed: (){
                    Get.dialog(
                        Dialog(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: List.generate(colorListFront.length, (index) {
                                return Center(
                                  child: Container(
                                    color: colorListFront[index],
                                    child: Obx(() {
                                      return InkWell(
                                        onTap: () async {
                                          await setFrontTimerColor(colorListFront[index].value);
                                          timerColor.frontTimerColor = colorListFront[index].value;
                                          Get.back();
                                        },
                                        focusColor: Color(timerColor.frontTimerColor),
                                      );
                                    })
                                  )
                                );
                              }),
                            ),
                          ),
                        )
                    );
                  },
                  child: const Text("띠 혹은 원 색")
              ),
            ],
          )
      ),
    );
  }
}
