import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daryo/presentation/widgets/dashboard/carousel/slider_item.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/models_daryo/slider/slider.dart';
import '../../../widgets/dashboard/slider_item.dart';

class SlidersCarousel extends StatefulWidget {
  const SlidersCarousel({
    super.key,
    required this.sliders,
    required this.onItemClicked,
  });

  final List<SliderModel> sliders;
  final Function(SliderModel item) onItemClicked;

  @override
  State<SlidersCarousel> createState() => _SlidersCarouselState();
}

class _SlidersCarouselState extends State<SlidersCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.sliders.length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: SliderItem(slider: widget.sliders[index],
                onItemClicked: widget.onItemClicked),
            );
          },
          options: CarouselOptions(
            viewportFraction: 0.98,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {},
          ),
        ),
      ],
    );
  }
}
