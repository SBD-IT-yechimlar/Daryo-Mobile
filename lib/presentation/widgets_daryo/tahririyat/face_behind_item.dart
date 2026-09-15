import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../domain/models_daryo/face_behind/face_behind.dart';
import '../../widgets/image/rounded_cached_network_image_widget.dart';


class FaceBehindItemWidget extends StatelessWidget {
  const FaceBehindItemWidget({
    super.key,
    required this.item,
    required this.onItemClicked,

  });

  final FaceBehind item;
  final Function(FaceBehind home) onItemClicked;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: context.containerBackground,
      child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            onItemClicked(item);
          },
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                RoundedCachedNetworkImage(
                  errorIcon: Container(
                    color: context.containerBackground,
                    child: Assets.imagesv2.aa.svg(),
                  ),
                  imageId:item.image ,
                  width: MediaQuery.of(context).size.width*0.5,
                  borderRadius: 16,
                  height: 200.h,
                ),
                Positioned(
                    bottom: 10,
                    left: 20,
                    right: 10,
                    child: item.fio.s(16).w(400).c(context.textSecondary))
              ],
            ),
          )
      ),
    );
  }
}
