import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/image_item/income_text.dart';
import 'package:flutter_bookkeeping/page/home/image_item/expend_text.dart';

class ImageItem extends StatelessWidget {
  ImageItem(
      {@required this.imageUrl,
      @required this.expendQuota,
      @required this.incomeQuota});

  final String imageUrl;
  final double expendQuota;
  final double incomeQuota;

  // 支出样式
  final expendStyle =
      TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Image.asset(
          imageUrl,
          fit: BoxFit.contain,
        ),
        Positioned(
          bottom: 48,
          left: 12,
          child: ExpendText(quota: expendQuota),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: IncomeText(quota: incomeQuota),
        ),
      ],
    );
  }
}
