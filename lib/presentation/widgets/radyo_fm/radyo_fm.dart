import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../domain/models_daryo/daryo_fm/darto_fm_item.dart';

class RadioFm extends StatefulWidget {

  final VoidCallback onNextClicked;
  final VoidCallback onPreviousClicked;
  final ValueChanged<DaryoFm?>? setInitialPlay;
  final ValueChanged<DaryoFm?>? onPause;
  final ValueChanged<DaryoFm?>? onResume;
  final ValueChanged<DaryoFm>? onPlayPauseChanged;
  final DaryoFm? item;

  final void Function(Future<void> Function() playPause)? onPlayerReady;
  const RadioFm({Key? key,
    required this.onNextClicked,
    required this.onPreviousClicked,
    required this.onPlayPauseChanged,
    required this.onPlayerReady,
    required this.setInitialPlay,
    required this.onPause,
    required this.onResume,
    required this.item,
  }) : super(key: key);

  @override
  State<RadioFm> createState() => _RadioFmState();
}

class _RadioFmState extends State<RadioFm> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool _hasPlayedOnce = false; // Birinchi play holatini kuzatish uchun

  DaryoFm? _currentItem;
  @override
  void initState() {
    super.initState();
     Logger().w("initState ${widget.item?.title}");
    _currentItem = widget.item;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPlayerReady?.call(playPause);
    });

    /// Audio holatlarini kuzatish
    _audioPlayer.onPlayerStateChanged.listen((state) {
      final playing = state == PlayerState.playing;

      setState(() {
        isPlaying = playing;
      });


    });

    /// Audio davomiyligini kuzatish
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    /// Audio pozitsiyasini kuzatish
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      widget.onNextClicked();
      Logger().w("Audio tugadi");
      print('Audio tugadi');
    });

  }

  @override
  void didUpdateWidget(covariant RadioFm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item != null && widget.item?.id != _currentItem?.id) {
      _currentItem = widget.item;
      _playNewAudio();
    }
  }

  Future<void> _playNewAudio() async {
    await _audioPlayer.stop();
    setState(() {
      position = Duration.zero;
      duration = Duration.zero;
      isPlaying = false;
    });
    final url = 'https://data.daryo.uz/media/${_currentItem?.audioPath}';
    await _audioPlayer.play(UrlSource(url));
    Logger().e("_playNewAudio  ${_currentItem?.title}");
     if (widget.setInitialPlay != null) {
          widget.setInitialPlay!(widget.item);
        }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> playPause() async {
    HapticFeedback.lightImpact();
    if (isPlaying) {
      await _audioPlayer.pause();
      if (widget.onPause != null) {
        widget.onPause!(widget.item);
      }
    } else {
      if (position > Duration.zero && position < duration) {
        widget.onResume!(widget.item);
        await _audioPlayer.resume();
      } else {
        if (widget.setInitialPlay != null) {
          widget.setInitialPlay!(widget.item);
        }
        await _audioPlayer.play(
          UrlSource('https://data.daryo.uz/media/${widget.item?.audioPath}'),
        );
      }
    }
  }


  Future<void> stop() async {
    await _audioPlayer.stop();
    setState(() {
      position = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16,left: 16,bottom: 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black,
        ),
        child: Stack(
          children: [
            /// radio image
            SizedBox(
              height: 110.h,
              child: Row(
                children: [
                  Assets.imagesv2.pngImages.radio.image()
                ],
              ),
            ),
            Container(
              height: 110.h,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12)
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 10.h,bottom: 10.h,left: 90.w,right: 18.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "${widget.item?.title}".s(14).w(400).c(Colors.white).copyWith(maxLines: 2,overflow: TextOverflow.ellipsis),
                  Column(mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 8.h),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6,
                        ),
                        trackHeight: 2,
                      ),
                      child: Slider(
                        padding: EdgeInsets.zero,
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        activeColor: Colors.white,
                        inactiveColor: Color(0xFF616161),
                        onChanged: (value) async {
                          final newPosition = Duration(seconds: value.toInt());
                          await _audioPlayer.seek(newPosition);
                        },
                      ),
                    ),
                      SizedBox(height: 3.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          formatTime(position).s(12).w(400).c(Colors.white),
                          formatTime(duration).s(12).w(400).c(Colors.white),
                        ],
                      ),
                    ),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Assets.images.icPrevious.svg(height: 18.h),
                        onPressed: (){
                          widget.onPreviousClicked();
                          HapticFeedback.lightImpact();

                        },
                      ),
                      SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)
                        ),
                        width: 30.h,
                        height:30.h ,
                        child: Center(
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.black,
                            ),
                            onPressed: playPause,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Assets.images.icNext.svg(height: 18.h),
                        onPressed: (){
                          widget.onNextClicked();
                          HapticFeedback.lightImpact();
                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}