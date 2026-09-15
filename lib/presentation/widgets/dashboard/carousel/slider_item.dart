import 'dart:ui';

import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models_daryo/slider/slider.dart';
import '../../../widgets/image/rounded_cached_network_image_widget.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({super.key, required this.slider,required this.onItemClicked});

  final SliderModel slider;
  final Function(SliderModel item) onItemClicked;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onItemClicked(slider);
      },
      child: AspectRatio(
        aspectRatio: 327 / 208,
        child: Stack(
          children: [
            Positioned.fill(
                child: RoundedCachedNetworkImage(
                  imageId: slider.img,
                  borderRadius: 16,
                )),
            Positioned(
              left: 14,
              top: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Text(slider.category).s(12).w(500).c(Colors.white),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 30, bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 2,
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              slider.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ).s(16).w(700).c(Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}