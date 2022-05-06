import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  List<String> imageData;
  double viewportFraction = 1.0;
  bool showDotIndicator;
  Carousel(
      {Key? key,
      required this.imageData,
      required this.viewportFraction,
      required this.showDotIndicator})
      : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  double currentIndexPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
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
              viewportFraction: widget.viewportFraction,
              reverse: false,
              enableInfiniteScroll: false,
              height: 200,
              onPageChanged: (index, _) {
                setState(() {
                  currentIndexPage = index.toDouble();
                });
              }),
        ),
        widget.showDotIndicator
            ? DotsIndicator(
                dotsCount: widget.imageData.length,
                position: currentIndexPage,
                decorator: const DotsDecorator(
                    color: Color(0xffC4C4C4), activeColor: Color(0xffD2137B)),
              )
            : const Offstage()
      ],
    );
  }
}
