import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  List<String> imageData;
  Carousel({Key? key, required this.imageData}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.imageData
          .map((imagePath) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SizedBox(
                  height: 80,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                    height: 70,
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        disableCenter: true,
        viewportFraction: 0.8,
        reverse: false,
        enableInfiniteScroll: false,
        height: 200,
      ),
    );
  }
}
