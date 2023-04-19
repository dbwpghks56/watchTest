import 'package:flutter/material.dart';

class SizedButton extends StatelessWidget {
  final String content;
  final GestureTapCallback onButtonPressed;
  final double boxWidth;
  final double boxHeight;

  const SizedButton({super.key,
    required this.content,
    required this.onButtonPressed,
    required this.boxHeight,
    required this.boxWidth
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      width: boxWidth,
      child: ElevatedButton(
        onPressed: onButtonPressed,
        child: Text(content,
          style: const TextStyle(fontSize: 8),
        )
      ),
    );
  }
}
