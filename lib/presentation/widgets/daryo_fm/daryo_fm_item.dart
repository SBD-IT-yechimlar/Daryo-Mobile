import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';


import '../../../domain/models_daryo/daryo_fm/darto_fm_item.dart';

class DaryoFmWidget extends StatelessWidget {
  final Function(DaryoFm item) onItemClicked;
  final DaryoFm item;
  const DaryoFmWidget({
    required this.onItemClicked,
    required this.item,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        color: context.isDarkMode? context.containerBackground:Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            HapticFeedback.lightImpact();
            onItemClicked(item);
          },
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.buttonInactiveBorder)
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      item.title.s(14).w(500).copyWith(maxLines: 2,overflow: TextOverflow.ellipsis).c(context.textPrimary),
                      SizedBox(height: 5),
                      formatDateTime(item.createdAt).s(10).c(context.colors.primary).w(400).copyWith(maxLines: 1,overflow: TextOverflow.ellipsis),
                    ],
                  )),
                  SizedBox(width: 12.w),
                  Material(
                    borderRadius:BorderRadius.circular(6),
                    color: Color(0xFFDFF1FF),
                    child: InkWell(
                      borderRadius:BorderRadius.circular(6),
                      onTap: (){
                        onItemClicked(item);
                        HapticFeedback.mediumImpact();
                      },
                      child: Container(
                        width: 25.h,
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: item.isPlaying?Assets.images.icPause.svg():Assets.imagesv2.icPlay.svg(),
                        ),
                      ),
                    ),
                  )
                ],),
              ),
            ),

          ),
        ),
      ),
    );
  }
  String formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      final formatted = '${dateTime.year.toString().padLeft(4, '0')}-'
          '${dateTime.month.toString().padLeft(2, '0')}-'
          '${dateTime.day.toString().padLeft(2, '0')} '
          '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
      return formatted;
    } catch (e) {
      return '';
    }
  }
}
