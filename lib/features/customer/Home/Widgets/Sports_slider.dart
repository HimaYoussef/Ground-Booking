import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NewsImageSlider extends StatefulWidget {
  const NewsImageSlider({super.key});

  @override
  State<NewsImageSlider> createState() => _NewsImageSliderState();
}

class _NewsImageSliderState extends State<NewsImageSlider> {
  List<Widget> images = [
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/offer1.png',
          height: 180,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/offer2.png',
          height: 180,
          fit: BoxFit.cover,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/offer5.png',
          height: 180,
          fit: BoxFit.cover,
        ))
  ];
  // int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: images,
            options: CarouselOptions(
              // onPageChanged: (index, reason) {
              //   setState(() {
              //     currentPage = index;
              //   });
              // },
              height: 160,
              viewportFraction: 0.95,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              scrollDirection: Axis.horizontal,
            )),
      ],
    );
  }
}
