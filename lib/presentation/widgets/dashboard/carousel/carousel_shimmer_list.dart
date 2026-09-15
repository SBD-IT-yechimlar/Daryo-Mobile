import 'package:carousel_slider/carousel_slider.dart';
import 'package:daryo/presentation/widgets/dashboard/carousel/slider_item_shimmer.dart';
import 'package:daryo/presentation/widgets/dashboard/carousel/slider_shorts_item_shimmer.dart';
import 'package:flutter/material.dart';

class SliderListShimmer extends StatelessWidget {
  const SliderListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIdx) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: SliderShortsItemShimmer(),
      ),
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
      ),
    );
  }
}

