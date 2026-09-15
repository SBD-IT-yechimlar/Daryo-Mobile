import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/domain/models_daryo/shorts/shorts.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShortsCarousel extends StatefulWidget {
  const ShortsCarousel({super.key, required this.shortsList});

  final List<Short> shortsList;

  @override
  State<ShortsCarousel> createState() => _ShortsCarouselState();
}

class _ShortsCarouselState extends State<ShortsCarousel> {
  int activeIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.shortsList.length,
          itemBuilder: (context, index, realIndex) {
            final short = widget.shortsList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ShortsItem(shorts: short),
            );
          },
          options: CarouselOptions(
            aspectRatio: 301 / 279,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) {
              setState(() => activeIndex = index);
            },
          ),
        ),
        const SizedBox(height: 16),
        if(widget.shortsList.isNotEmpty)
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: widget.shortsList.length,
          effect: ExpandingDotsEffect(
            activeDotColor: Colors.white,
            dotColor: Color(0xFFACB5BB),
            dotHeight: 4,
            dotWidth: 6,
            spacing: 6,
          ),
          onDotClicked: (index) => _controller.animateToPage(index),
        ),
      ],
    );
  }
}

class ShortsItem extends StatelessWidget {
  const ShortsItem({super.key, required this.shorts});

  final Short shorts;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 301 / 279,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          launchUrlString(shorts.link);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: RoundedCachedNetworkImage(
                  imageId: shorts.image,
                  borderRadius: 16,
                ),
              ),
              // Positioned(
              //   bottom: 18,
              //   left: 20,
              //   right: 20,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(12),
              //     child: BackdropFilter(
              //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //       child: Container(
              //         padding:
              //             const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              //         decoration: BoxDecoration(
              //           color: Colors.black.withOpacity(0.3),
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //         child: IntrinsicHeight(
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.stretch,
              //             children: [
              //               Container(
              //                 width: 2,
              //                 decoration: BoxDecoration(
              //                   color: context.colors.primary,
              //                   borderRadius: BorderRadius.circular(2),
              //                 ),
              //               ),
              //               const SizedBox(width: 12),
              //               Expanded(
              //                 child:
              //                     Text(shorts.title).s(20).w(700).c(Colors.white),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
