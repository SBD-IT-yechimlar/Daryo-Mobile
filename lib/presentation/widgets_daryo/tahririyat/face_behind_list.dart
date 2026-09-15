import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../domain/models_daryo/face_behind/face_behind.dart';
import 'face_behind_item.dart';

class FaceBehindListWidget extends StatelessWidget {
  const FaceBehindListWidget({
    super.key,
    required this.faceBehindList,
    required this.onItemClicked,
  });

  final List<FaceBehind> faceBehindList;
  final Function(FaceBehind item) onItemClicked;


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height:200.h,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: faceBehindList.length,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return FaceBehindItemWidget(
              item: faceBehindList[index],
              onItemClicked: onItemClicked,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 10);
          },
        ),
      ),
    );
  }
}
