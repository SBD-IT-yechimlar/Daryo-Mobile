/*
import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../domain/models_daryo/video/video.dart';
import '../../widgets/dashboard/recommendation/rec_item.dart';

class VideoViewerDialog extends StatefulWidget {
  const VideoViewerDialog({super.key, required this.video, required this.parentContext});

  final Video video;

  final BuildContext parentContext;

  static Future<dynamic> show(BuildContext parentContext, {required Video video}) async {
    return showDialog(
      barrierColor: Colors.black38,
      context: parentContext,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        backgroundColor: context.containerBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayerController.convertUrlToId(widget.video.uLink) ?? '';

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableCaption: false,
        strictRelatedVideos: true,
      ),
    )..loadVideoById(videoId: videoId);
    _controller.listen((YoutubePlayerValue data) {});
    // 🔹 Listen to fullscreen changes
    _controller.setFullScreenListener((isFullScreen) {
      print("isFullScreen: $isFullScreen");
      if (true) {
        // Exited fullscreen → reset to portrait
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }


  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                icon: Assets.imagesDaryo.back.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                onPressed: () {
                  Navigator.pop(context);
                  HapticFeedback.lightImpact();
                },
              ),
              Spacer(),
            */
/*  IconButton(
                icon: Assets.imagesDaryo.save.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                onPressed: () {
                  HapticFeedback.lightImpact();
                },
              ),*//*

              IconButton(
                  icon: Assets.imagesDaryo.share.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                  onPressed: () {
                    Share.share(widget.video.uLink);
                    HapticFeedback.lightImpact();
                  }),
              */
/* GestureDetector(
                onTap: () {
                 *//*
 */
/* SharePlus.instance
                      .share(ShareParams(text: widget.video.uLink));*//*
 */
/*
                },
                child: Assets.imagesDaryo.share.svg(),
              ),*//*

            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: YoutubePlayerScaffold(
                controller: _controller,
                aspectRatio: 16 / 9,
                autoFullScreen: true,
                fullscreenOrientations: const [
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ],
                lockedOrientations: const [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
                builder: (context, player) => player,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(widget.video.title).s(14).w(500).c(context.textPrimary),
          const SizedBox(height: 12),
          Row(
            children: [
              "Demo Text".s(12).w(500).c(context.colors.primary),
              const Spacer(),
              Assets.imagesDaryo.clock.svg(),
              const SizedBox(width: 4),
              Text(formatDate(widget.video.date)).s(12).w(400).c(context.textSecondary),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Container(
                height: 44,
                width: 142,
                decoration: BoxDecoration(color: context.backgroundColor, borderRadius: BorderRadius.circular(100)),
                child: Row(
                  children: [
                    Flexible(
                        child: GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                      },
                      child: SizedBox(
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [Assets.imagesv2.icLike.svg(), SizedBox(width: 3), "123".s(12).w(400).c(context.textSecondary)],
                        ),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        width: 1,
                        color: context.iconPrimary,
                      ),
                    ),
                    Flexible(
                        child: GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                      },
                      child: SizedBox(
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [Assets.imagesv2.icDislike.svg(), SizedBox(width: 3), "321".s(12).w(400).c(context.textSecondary)],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.parentContext.router.push(CommentRoute());
                },
                icon: Badge(
                  label: Text("1").w(400).c(context.textPrimary),
                  child: Assets.imagesDaryo.messages.svg(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/


import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/core/gen/assets/assets.gen.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/models_daryo/video/video.dart';
import '../../widgets/dashboard/recommendation/rec_item.dart';

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
      barrierColor: Colors.black38,
      context: parentContext,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        backgroundColor: context.containerBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    final videoId = YoutubePlayer.convertUrlToId(widget.video.uLink) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        hideControls: false,
        controlsVisibleAtStart: true,
        forceHD: false,
        useHybridComposition: true,
      ),
    );

    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light,
          ),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    // Landscape holatdan chiqish
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Status bar'ni asl holatiga qaytarish
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark, // Bu qatorni o'zgartiring
      ),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: context.colors.primary,
        onReady: () {
          /// Player tayyor bo‘ldi
        },
        onEnded: (data) {
          /// video tugaganda ishlaydi
        },
      ),
      builder: (context, player) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                decoration: BoxDecoration(
                  color: context.backgroundWhiteColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Material(
                  color:  context.backgroundWhiteColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        IconButton(
                          onPressed: (){
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                            icon: Assets.images.icExit.svg()),

                          IconButton(
                          icon: Assets.imagesDaryo.share.svg(
                              colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                          onPressed: () {
                            Share.share(widget.video.uLink);
                            HapticFeedback.lightImpact();
                          },
                        ),
                      ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: player,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(widget.video.title).s(14).w(500).c(context.textPrimary),
                      const SizedBox(height: 12),
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
              )
             /* Row(
                children: [
                  Container(
                    height: 44,
                    width: 142,
                    decoration: BoxDecoration(
                      color: context.backgroundColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                            },
                            child: SizedBox(
                              height: 44,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Assets.imagesv2.icLike.svg(),
                                  const SizedBox(width: 3),
                                  "123".s(12).w(400).c(context.textSecondary),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            width: 1,
                            color: context.iconPrimary,
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                            },
                            child: SizedBox(
                              height: 44,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Assets.imagesv2.icDislike.svg(),
                                  const SizedBox(width: 3),
                                  "321".s(12).w(400).c(context.textSecondary),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.parentContext.router.push(CommentRoute());
                    },
                    icon: Badge(
                      label: Text("1").w(400).c(context.textPrimary),
                      child: Assets.imagesDaryo.messages.svg(),
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        );
      },
    );
  }
}
