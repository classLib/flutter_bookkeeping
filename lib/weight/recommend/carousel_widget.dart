import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// 轮播图
class CarouselWidget extends StatefulWidget {
  List<dynamic> imgs;
  List<Function> callbacks;

  CarouselWidget(this.imgs, {this.callbacks});

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        // 配置图片地址
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: widget.imgs[index],
            fit: BoxFit.cover,
          ),
        );
      },
      // 配置图片数量
      itemCount: widget.imgs.length,
      // 底部分页器
      pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
        color: Colors.grey,
        activeColor: Colors.white,
      )),
      // 左右箭头
      // control: new SwiperControl(),
      // 无限循环
      loop: true,
      // 自动轮播
      autoplay: true,
      onTap: (index) {
        widget.callbacks[index]();
      },
    );
  }
}
