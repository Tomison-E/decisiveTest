import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'dart:io';
import 'package:decisive/ui/widgets/profileCard.dart';

  // ignore: must_be_immutable
  class Carousel extends StatelessWidget {
  final _controller = PageController(initialPage: 0);
   final List<File> images;

  Carousel({this.images= const[null,null,null,null,null,null]}):assert(images.length==6);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: PageIndicatorContainer(
        align: IndicatorAlign.bottom,
        length:  images.length,
        indicatorSpace: 10,
        padding: EdgeInsets.all(2.0),
        shape: IndicatorShape.circle(size: 7.0),
        indicatorColor: Colors.grey.shade200,
        indicatorSelectorColor: Colors.black,
        child: PageView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: images.map((image)=> ProfileCard(image: image)).toList()),
        ),
    );
  }
}
