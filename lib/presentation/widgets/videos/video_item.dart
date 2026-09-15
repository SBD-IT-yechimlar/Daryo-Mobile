import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/domain/models_daryo/video/video.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/videos/video_viewer_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../widgets/dashboard/recommendation/rec_item.dart';
import '../image/rounded_cached_network_image_widget.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      //  VideoViewerDialog.show(context, video: video);
        /*Navigator.push(
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
        constraints: const BoxConstraints(minHeight: 80),
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
                      ).s(14).w(500).c(Colors.white),
                      Spacer(),
                      Row(
                        children: [
                          Spacer(),
                          // Expanded(
                          //     child: Text(video.category)
                          //         .s(12)
                          //         .w(500)
                          //         .c(context.colors.primary)),
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

class VideosList extends StatelessWidget {
  const VideosList({super.key, required this.videos});

  final List<Video> videos;

  @override
  Widget build(BuildContext context) {
    final firstVideo = videos.firstOrNull;
    final subVideos = videos.skip(1).toList();
    return Column(
      children: [
        if (firstVideo != null)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false, // background opacity ishlashi uchun
                  pageBuilder: (_, __, ___) => Stack(
                    children: [
                      Container(color: Colors.black38), // opacity fon
                      Center(
                        child: VideoViewerDialog(video: firstVideo, parentContext: context),
                      ),
                    ],
                  ),
                ),
              );
            },

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 327 / 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: RoundedCachedNetworkImage(
                          imageId: firstVideo.image,
                          width: 110,
                          borderRadius: 16,
                          height: 80,
                        ),
                      ),
                      Center(child: Assets.imagesDaryo.button.svg(height: 80)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  firstVideo.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ).s(14).w(500).c(Colors.white),
                SizedBox(height: 12),
                Row(
                  children: [
                    Spacer(),
                    Assets.imagesDaryo.clock.svg(),
                    SizedBox(width: 4),
                    Text(formatDate(firstVideo.date))
                        .s(12)
                        .w(400)
                        .c(context.textSecondary),
                  ],
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
        ...List.generate(subVideos.length, (index) {
          final video = subVideos[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: VideoItem(video: video),
          );
        })
      ],
    );
  }
}
