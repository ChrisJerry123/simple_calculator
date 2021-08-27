import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final color;
  final textColor;
  final String textButton;
  final buttonTapped;

  CalculatorButton(
      {this.color, this.textButton, this.textColor, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Center(
            child: Text(textButton,
                style: TextStyle(color: textColor, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
