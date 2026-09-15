import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:daryo/presentation/widgets/button/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../../../domain/models_daryo/tariff/tariff.dart';


@RoutePage()
class TariffPaymentOptionPage extends StatefulWidget {
  const TariffPaymentOptionPage({super.key, required this.tariff});

  final Tariff tariff;

  @override
  State<TariffPaymentOptionPage> createState() =>
      _TariffPaymentOptionPageState();
}

class _TariffPaymentOptionPageState extends State<TariffPaymentOptionPage> {
  PaymentOption? selectedPaymentOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        context: context,
        titleText: "Tarif usulini tanlang",
        titleTextColor: Colors.black,
        backgroundColor: Colors.white,
        onBackPressed: () => context.router.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFDFF1FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.tariff.title)
                                .w(500)
                                .c(context.colors.primary),
                            Text("${widget.tariff.amountUzs.toString()} uzs").w(500)
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        spacing: 16,
                        children: [
                          buildOption(
                              icon: Assets.imagesDaryo.click.svg(),
                              isSelected:
                                  selectedPaymentOption == PaymentOption.click,
                              onTap: () {
                                setState(() {
                                  selectedPaymentOption = PaymentOption.click;
                                });
                              }),
                          buildOption(
                              icon: Assets.imagesDaryo.pngImages.payme.image(),
                              isSelected:
                                  selectedPaymentOption == PaymentOption.payme,
                              onTap: () {
                                setState(() {
                                  selectedPaymentOption = PaymentOption.payme;
                                });
                              }),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        spacing: 16,
                        children: [
                          buildOption(
                              icon: Assets.imagesDaryo.uzum.svg(),
                              isSelected:
                                  selectedPaymentOption == PaymentOption.uzum,
                              onTap: () {
                                setState(() {
                                  selectedPaymentOption = PaymentOption.uzum;
                                });
                              }),
                          buildOption(
                              icon: Assets.imagesDaryo.ofb.svg(),
                              isSelected:
                                  selectedPaymentOption == PaymentOption.ofb,
                              onTap: () {
                                setState(() {
                                  selectedPaymentOption = PaymentOption.ofb;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    text: "Obuna bo'lish",
                    onPressed: () {
                      context.router.push(TariffPaymentSuccessRoute());
                    },
                    isEnabled: selectedPaymentOption != null,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 6,
                      children: [
                        Text("Barcha huquqlar himoyalangan!")
                            .s(12)
                            .w(500)
                            .c(Color(0xFF6C7278)),
                        GestureDetector(
                          onTap: () {},
                          child: Text("Ommaviy oferta")
                              .s(12)
                              .w(600)
                              .c(context.colors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption({
    required Widget icon,
    required Function() onTap,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(
              width: isSelected ? 2 : 1,
              color: isSelected ? context.colors.primary : Color(0xFFEFF0F6),
            ),
            borderRadius: BorderRadius.circular(19),
          ),
          child: icon,
        ),
      ),
    );
  }
}

enum PaymentOption { click, payme, uzum, ofb }
