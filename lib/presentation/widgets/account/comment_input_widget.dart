import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';

class CommentInputWidget extends StatefulWidget {
  const CommentInputWidget({super.key});

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isPressed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 10),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: context.containerBackground,
        /*boxShadow: const [
          BoxShadow(
            color: Color(0x1A111827),
            blurRadius: 24,
            offset: Offset(-8, 4),
          ),
        ],*/
      ),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.buttonInactiveBorder,
            width: 1,
          ),
          /*boxShadow: const [
            BoxShadow(
              color: Color(0x3DE4E5E7),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],*/
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _controller,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Fikringizni yozing...',
                    hintStyle: TextStyle(
                      color: context.textSecondary,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                    color: context.textPrimary,
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.send,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _isPressed = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _isPressed = false;
                });
              },
              onTapCancel: () {
                setState(() {
                  _isPressed = false;
                });
              },
              onTap: () {},
              child: AnimatedScale(
                scale: _isPressed ? 0.85 : 1.0,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                child:
                    Assets.imagesDaryo.icCommentSend2.svg(height: 24, width: 24, colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
