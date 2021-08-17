import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// FileName: filter_widget
/// Author: hjy
/// Date: 2021/8/13 11:37
/// Description:筛选组件

class FilterWidget extends StatefulWidget {
  final List<String> list;
  final String title;
  const FilterWidget({Key key, this.list, this.title}) : super(key: key);
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  var _valueKey;
  //点击
  _onTap(key) {

  }
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.date_range),
      title: Text(
        widget.title,
      ),
      initiallyExpanded: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.list.map((key) {
              return InkWell(
                onTap: () {
                  _onTap(key);
                },
                child: Container(
                  width:  45,
                  height: 40,
                  child: Text(key),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
