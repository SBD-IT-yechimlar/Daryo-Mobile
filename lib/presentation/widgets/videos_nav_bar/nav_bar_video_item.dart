import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../domain/models_daryo/video/video.dart';
import '../../widgets/image/rounded_cached_network_image_widget.dart';
import '../../widgets/videos/video_viewer_dialog.dart';
import '../../widgets/dashboard/recommendation/rec_item.dart';

class VideoNabBarItem extends StatelessWidget {
  const VideoNabBarItem({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
     //   VideoViewerDialog.show(context, video: video);
     /*   Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Material(
                color: Colors.black26,
                child: VideoViewerDialog(video: video, parentContext: context,)),
          ),
        );*/
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false, // background opacity ishlashi uchun
            pageBuilder: (_, __, ___) => Stack(
              children: [
                Container(color: Colors.black38), // opacity fon
                Center(
                  child: VideoViewerDialog(video: video, parentContext: context),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        color: context.backgroundColor,
        constraints: BoxConstraints(minHeight: 80),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 110,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: RoundedCachedNetworkImage(
                        imageId: video.image,
                        width: 110,
                        borderRadius: 16,
                        height: 80,
                      ),
                    ),
                    Center(child: Assets.imagesDaryo.button.svg()),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ).s(14).w(500).c(context.textPrimary),
                      Spacer(),
                      Row(
                        children: [
                        //  "Demo text".s(12).w(500).c(context.colors.primary),
                          Spacer(),
                          Text(formatDate(video.date))
                              .s(12)
                              .w(400)
                              .c(context.textSecondary),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}