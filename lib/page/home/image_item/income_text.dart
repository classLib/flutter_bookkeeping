import 'package:flutter/material.dart';

class IncomeText extends StatelessWidget {
  final double quota;

  final incomeTitleStyle = TextStyle(color: Colors.orangeAccent);

  final incomeStyle = TextStyle(color: Colors.white);

  IncomeText({@required this.quota});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "本月收入 ",
          style: incomeTitleStyle,
        ),
        Text(
          quota.toStringAsFixed(2),
          style: incomeStyle,
        )
      ],
    );
  }
}
