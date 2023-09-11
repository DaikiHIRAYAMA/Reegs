import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final double widthFactor;

  CustomElevatedButton({
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
    this.fontSize = 24,
    this.widthFactor = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fixedSize: Size(screenSize.width * widthFactor, 50),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }
}
