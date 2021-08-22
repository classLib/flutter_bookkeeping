import 'package:flutter/material.dart';

class ExpendText extends StatelessWidget {
  final double quota;

  final expendStyle =
      TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold);

  ExpendText({@required this.quota});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          quota.toStringAsFixed(2),
          style: expendStyle,
        )
      ],
    );
  }
}
