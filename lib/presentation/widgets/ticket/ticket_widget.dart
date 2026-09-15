import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/ticket/ticket_clipper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';

class SubscriptionCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color buttonColor;
  final Color borderColor;
  final String? price;
  final String? priceSubtitle;
  final Function onItemClicked;

  const SubscriptionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.buttonColor,
    required this.borderColor,
    required this.onItemClicked,
    this.price,
    this.priceSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TicketClipper(),
        child: CustomPaint(
          painter: TicketBorderPainter(
            borderColor: context.isDarkMode? borderColor:Color(0xFFEFF0F6),
            backgroundColor: context.isDarkMode? context.containerBackground:Colors.white,
            borderWidth: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        icon,
                        const SizedBox(width: 6),
                        Expanded(
                          child: title.s(16).w(500).c(buttonColor).h(1),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    subtitle.s(12).w(400).c(context.textSecondary),
                  ],
                ),
                SizedBox(height: 8),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: StaticColors.lightBorder,
                  dashGapLength: 4.0,
                ),
                SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (price??"").s(20).w(700).c(buttonColor),
                        (priceSubtitle??"").s(12).w(400).c(context.textSecondary)
                      ],
                    ),
                    // Button
                    ElevatedButton(
                      onPressed: () {
                       onItemClicked();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.imagesDaryo.icTicketWalletAdd.svg(),
                          const SizedBox(width: 10),
                          buttonText.s(14).w(500).c(StaticColors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}