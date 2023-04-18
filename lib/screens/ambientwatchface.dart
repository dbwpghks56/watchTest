import 'package:flutter/material.dart';

class Ambientwatchface extends StatelessWidget {
  const Ambientwatchface({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Wear Timer",
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 30
              ),
            ),
            const SizedBox(height: 15,),
            const FlutterLogo(size: 60.0,),
          ],
        ),
      ),
    );
  }
}
