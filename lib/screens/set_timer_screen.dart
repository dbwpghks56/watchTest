import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watchtest/model/PaintingChange.dart';
import 'package:watchtest/model/TimerModel.dart';

class SetTimerScreen extends StatelessWidget {
  final timerModel = Get.put(TimerModel());
  final paintingChange = Get.put(PaintingChange());
  SetTimerScreen({Key? key}) : super(key: key);

  Future<void> setPaintingType(String paintingStyle) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("paintStyle", paintingStyle);
  }

  @override
  Widget build(BuildContext context) {
    var colorList = [Colors.blue, Colors.redAccent, Colors.green, Colors.grey, Colors.black, Colors.blueGrey];
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
                              children: List.generate(6, (index) {
                                return Center(
                                  child: Text(
                                    'Item $index',
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      );
                    },
                    child: Text("배경 색")
                ),
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
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              // Generate 100 widgets that display their index in the List.
                              children: List.generate(colorList.length, (index) {
                                return Center(
                                  child: Container(
                                    color: colorList[index],
                                  )
                                );
                              }),
                            ),
                          ),
                        )
                    );
                  },
                  child: Text("띠 혹은 원 색")
              ),
            ],
          )
      ),
    );
  }
}
