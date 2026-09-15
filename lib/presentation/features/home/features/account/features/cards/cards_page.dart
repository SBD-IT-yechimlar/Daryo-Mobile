import 'package:auto_route/auto_route.dart';
import 'package:blur/blur.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/features/home/features/account/features/cards/features/add_card/add_card_sheet.dart';
import 'package:daryo/presentation/features/home/features/account/features/cards/features/edit_card/edit_card_sheet.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // add in pubspec.yaml

import '../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../core/gen/localization/strings.dart';

@RoutePage()
class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  final pageController = PageController();
  int currentIndex = 0;

  final cards = <CardModel>[
    CardModel(
      cardNumber: "1234567812345678",
      cardExpirationDate: "06/26",
      cardName: "Oylik kartam",
      isMain: true,
      cardHolderName: "John Doe",
      cardType: "VISA",
    ),
    CardModel(
      cardNumber: "8600123412341234",
      cardExpirationDate: "07/27",
      cardName: "Shaxsiy karta",
      isMain: false,
      cardHolderName: "John Doe",
      cardType: "UZCARD",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final allCards = [...cards, null];

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: DefaultAppBar(
        context: context,
        titleText: "",
        titleWidget: context.isDarkMode
            ? Assets.imagesv2.appabarLogoDark.svg(width: 100.w)
            : Assets.imagesv2.appabarLogo.svg(width: 100.w),
        titleTextColor: context.textPrimary,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 12),
                              Strings.myPaymentCards.w(700).s(32),
                              SizedBox(height: 12),
                              Strings.currentBalance.s(12).w(500).c(context.textSecondary),
                              "0 so'm".w(700).s(24),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: (327 + 2 * 24) / 207,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: allCards.length,
                            onPageChanged: (index) {
                              setState(() => currentIndex = index);
                            },
                            itemBuilder: (context, index) {
                              final card = allCards[index];
                              return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: card == null
                                      ? GestureDetector(
                                          onTap: () => AddCardSheet.show(context),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              color: const Color(0xFFD9DDDF),
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              spacing: 15,
                                              children: [
                                                Assets.imagesDaryo.add.svg(),
                                                Strings.addNewCard.toUpperCase().w(500).c(Color(0xFF616161)),
                                              ],
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            EditCardSheet.show(context, card: card);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                              gradient: const LinearGradient(
                                                colors: [Color(0xFF1A237E), Color(0xFF283593)],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(card.cardName ?? "").s(14).w(500).c(Colors.white),
                                                    Text(card.cardType).s(14).w(600).c(Colors.white),
                                                  ],
                                                ),
                                                Text(
                                                  card.cardNumber.replaceAllMapped(
                                                    RegExp(r".{4}"),
                                                    (match) => "${match.group(0)} ",
                                                  ),
                                                ).s(20).w(700).c(Colors.white),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(card.cardHolderName).s(14).w(500).c(Colors.white70),
                                                    Text(card.cardExpirationDate).s(14).w(500).c(Colors.white70),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 12),
                              Center(
                                child: SmoothPageIndicator(
                                  controller: pageController,
                                  count: allCards.length,
                                  effect: ExpandingDotsEffect(
                                    dotHeight: 6,
                                    dotWidth: 6,
                                    spacing: 6,
                                    activeDotColor: context.colors.primary,
                                    dotColor: const Color(0xFFD9DDDF),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(Strings.useAutopayService),
                                        ),
                                        Switch(
                                          inactiveThumbColor:context.isDarkMode? Colors.white: StaticColors.lightButtonInactiveBorder,
                                          activeTrackColor: context.colors.primary,
                                          value: false,
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                    Strings.autopayDescription.s(11).c(context.textSecondary),
                                    const SizedBox(height: 24),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        spacing: 6,
                                        children: [
                                          Strings.viewPaymentHistory.w(500).c(context.brownClickColor),
                                          Icon(Icons.chevron_right, size: 20, color: context.brownClickColor),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        spacing: 6,
                                        children: [
                                          Strings.goToTariffPlans.w(500).c(context.brownClickColor),
                                          Icon(Icons.chevron_right, size: 20, color: context.brownClickColor),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    children: [
                      Strings.usingPaymentCards.s(12).w(500).c(context.textSecondary),
                      GestureDetector(
                        onTap: () {},
                        child: Strings.publicOffer.s(12).w(600).c(context.colors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Stack(
            children: [
              Blur(
                blur: 3,
                blurColor: context.backgroundWhiteColor.withOpacity(0.7),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: "".s(12).w(400),
                    ),
                  ],
                ),
              ),
              Center(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Strings.inProgressPart.s(16).w(500).c(context.textPrimary).copyWith(textAlign: TextAlign.center),
              ))
            ],
          ),
        ],
      ),
    );
  }
}

class CardModel {
  final String cardNumber;
  final String cardExpirationDate;
  final String? cardName;
  final String cardHolderName;
  final bool isMain;
  final String cardType;

  CardModel({
    required this.cardNumber,
    required this.cardExpirationDate,
    this.cardName,
    required this.cardHolderName,
    required this.isMain,
    required this.cardType,
  });
}
