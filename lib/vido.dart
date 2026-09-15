import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/dashboard/recommendation/rec_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/models_daryo/video/video.dart';

class VideoViewerDialog extends StatefulWidget {
  const VideoViewerDialog({
    super.key,
    required this.video,
    required this.parentContext,
  });

  final Video video;
  final BuildContext parentContext;

  static Future<dynamic> show(BuildContext parentContext, {required Video video}) async {
    return showDialog(
      barrierColor: Colors.black87, // Ko'proq kontrast
      context: parentContext,
      useSafeArea: true, // Muhim!
      barrierDismissible: false, // Tasodifan yopilishini oldini olish
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero, // To'liq ekran uchun
        backgroundColor: Colors.transparent,
        child: VideoViewerDialog(
          video: video,
          parentContext: parentContext,
        ),
      ),
    );
  }

  @override
  State<VideoViewerDialog> createState() => _VideoViewerDialogState();
}

class _VideoViewerDialogState extends State<VideoViewerDialog> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    final videoId = YoutubePlayer.convertUrlToId(widget.video.uLink) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false, // Dialog ochilganda avtomatik boshlanmasin
        mute: false,
        enableCaption: false,
        isLive: false,
        forceHD: false,
        controlsVisibleAtStart: true,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.isReady && !_isPlayerReady) {
        setState(() {
          _isPlayerReady = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Video to'xtatish
        if (_controller.value.isPlaying) {
          _controller.pause();
        }
        return true;
      },
      child: Container(
        color: context.containerBackground,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        icon: Assets.imagesDaryo.back.svg(
                          colorFilter: ColorFilter.mode(
                            context.iconPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          }
                          Navigator.pop(context);
                          HapticFeedback.lightImpact();
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Assets.imagesDaryo.share.svg(
                          colorFilter: ColorFilter.mode(
                            context.iconPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {
                          Share.share(widget.video.uLink);
                          HapticFeedback.lightImpact();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Video Player
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: context.colors.primary,
                        progressColors: ProgressBarColors(
                          playedColor: context.colors.primary,
                          handleColor: context.colors.primary,
                        ),
                        onReady: () {
                          setState(() {
                            _isPlayerReady = true;
                          });
                        },
                        onEnded: (data) {
                          // Video tugaganda
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Title
                  Text(widget.video.title)
                      .s(14)
                      .w(500)
                      .c(context.textPrimary),

                  const SizedBox(height: 12),

                  // Date info
                  Row(
                    children: [
                      "".s(12).w(500).c(context.colors.primary),
                      const Spacer(),
                      Assets.imagesDaryo.clock.svg(),
                      const SizedBox(width: 4),
                      Text(formatDate(widget.video.date))
                          .s(12)
                          .w(400)
                          .c(context.textSecondary),
                    ],
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}