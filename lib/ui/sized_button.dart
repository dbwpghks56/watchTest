import 'package:flutter/material.dart';
import 'package:watchtest/enum/ChildType.dart';

class SizedButton extends StatelessWidget {
  final String? content;
  final GestureTapCallback onButtonPressed;
  final double boxWidth;
  final double boxHeight;
  final ChildType? childType;
  final Icon? icon;

  const SizedButton({super.key,
    this.childType,
    this.icon,
    this.content,
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
        child: childType == null ? Text(content!,
          style: const TextStyle(fontSize: 8),
        ) : icon,
      ),
    );
  }
}
