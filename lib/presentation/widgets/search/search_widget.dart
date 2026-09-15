import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../domain/models_daryo/recommendation/recommendation.dart';
import '../dashboard/recommendation/rec_item.dart';
import '../image/rounded_cached_network_image_widget.dart';

class SearchItemWidget extends StatelessWidget {
  const SearchItemWidget({super.key, required this.recommendation});

  final Common recommendation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        HapticFeedback.lightImpact();
      },
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            RoundedCachedNetworkImage(
              imageId: recommendation.img,
              width: 110,
              borderRadius: 16,
              height: 80,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendation.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ).s(14).w(500),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: Text(recommendation.category)
                                .s(12)
                                .w(500)
                                .c(context.colors.primary)),
                        Text(formatDate(recommendation.date))
                            .s(12)
                            .w(400)
                            .c(Color(0xFF6C7278)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}