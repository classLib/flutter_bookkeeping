import 'package:flutter_pickers/time_picker/model/date_mode.dart';

/// FileName: handle_list
/// Author: hjy
/// Date: 2021/8/24 18:57
/// Description:

class HandleList {
  //处理得到数据list
  getListData(list, dataAll, model, p) {
    list.clear();
    if (model == DateMode.YM) {
      for (var each in dataAll) {
        var year = DateTime.parse(each.recordTime).year;
        var month = DateTime.parse(each.recordTime).month;
        if (year == p.year && month == p.month) list.add(each);
      }
    } else {
      for (var each in dataAll) {
        var year = DateTime.parse(each.recordTime).year;
        if (year == p.year) list.add(each);
      }
    }
    return list;
  }

//  分出支出和收入
  getDivideData(List pay, List income, List list) {
    income.clear();
    pay.clear();
    for (var item in list) {
      if (item.recordCategoryNum == 1) {
        pay.add(item);
      } else {
        income.add(item);
      }
    }
    return [income, pay];
  }

  //面积图数据处理
  handleAreaData(List yearCur, String _yearKey, areaData) {
    var year = int.parse(_yearKey);
    areaData = [0.0];
    //闰年
    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
      for (var i = 0; i < 366; i++) {
        areaData.add(0.0);
      }
    } else {
      for (var i = 0; i < 365; i++) {
        areaData.add(0.0);
      }
    }
    for (var i = 0; i < yearCur.length; i++) {
      var cur = yearCur[i];
      var d1 = new DateTime(year, 1, 1);
      var d2 = DateTime(year, DateTime.parse(cur.recordTime).month,
          DateTime.parse(cur.recordTime).day);
      var difference = d2.difference(d1);
      areaData[difference.inDays] += cur.recordNumber;
    }
    return areaData;
  }

  //处理饼图数据，this.data
  handlePie(List month, List data) {
    var legendData = Set<String>.from(
        month.asMap().keys.map((i) => month[i].recordCategoryName)).toList();
    data.clear();
    for (var i = 0; i < legendData.length; i++) {
      data.add({"value": 0, "name": legendData[i]});
    }
    for (var i = 0; i < month.length; i++) {
      for (var j = 0; j < legendData.length; j++) {
        if (month[i].recordCategoryName == legendData[j]) {
          data[j]["value"] =
              double.parse(data[j]["value"].toString()) + month[i].recordNumber;
        }
      }
    }
    return [data, legendData];
  }
  //图标,this.menuIcons
  handleIcon(List month,List menuIcons) {
    menuIcons.clear();
    for (var item in month) {
      menuIcons.add(item.recordImage);
    }
    return menuIcons;
  }
}
