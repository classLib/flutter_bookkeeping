import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// FileName: head_util
/// Author: hjy
/// Date: 2021/8/11 10:31
/// Description:

class HeadUtil extends StatefulWidget {
  const HeadUtil({Key key}) : super(key: key);

  @override
  _HeadUtilState createState() => _HeadUtilState();
}

class _HeadUtilState extends State<HeadUtil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      height: 200.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //头像居中
          children: <Widget>[
            Container(
              width: 110.0,
              height: 110.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: 10.0, //加间距
            ),
            Text("随手记账 1.0")
          ],
        ),
      ),
    );
  }
}
