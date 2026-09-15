import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/domain/models_daryo/tariff/tariff.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../domain/models/currency/currency_code.dart';
import '../../router/app_router.dart';
import '../../support/colors/static_colors.dart';
import '../../widgets/account/custom_elevated_button.dart';
import '../../widgets/currency/custom_list_price_text_widget.dart';

class TariffsCarousel extends StatefulWidget {
  const TariffsCarousel({super.key, required this.tariffs});

  final List<Tariff> tariffs;

  @override
  State<TariffsCarousel> createState() => _TariffsCarouselState();
}

class _TariffsCarouselState extends State<TariffsCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _controller,
      itemCount: widget.tariffs.length,
      itemBuilder: (context, index, realIndex) => TariffItem(tariff: widget.tariffs[index]),
      options: CarouselOptions(
        aspectRatio: 1.2,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        onPageChanged: (index, reason) {},
      ),
    );
  }
}

class TariffItem extends StatelessWidget {
  const TariffItem({super.key, required this.tariff});

  final Tariff tariff;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: tariff.id == 6 ? context.colors.primary : Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6),
                child: Text("Eng mashhur").s(12).w(500).c((tariff.id == 6)?StaticColors.white:Colors.transparent),
              ),
            ),
          ),
          Positioned.fill(
            top: 26,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: context.containerBackground,
                border: Border.all(
                  color: tariff.id == 6 ? context.colors.primary : context.inputStrokeInactiveColor,
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tariff.title.s(20).w(700).c(context.textPrimary),
                      const SizedBox(height: 10),
                      Flexible(child: tariff.description.s(12).w(400).c(context.textSecondary).copyWith(overflow: TextOverflow.visible, softWrap: true, maxLines: 2)),
                      const SizedBox(height: 10),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomListPriceTextWidget(
                                size: 32, w: 700, color: context.textPrimary, price: tariff.amountUzs, currency: CurrencyCode.uzs),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButton(
                        text: "${tariff.title} ni oling",
                        onPressed: () {
                          context.router.push(TariffPaymentOptionRoute(
                            tariff: tariff,
                          ));
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        spacing: 6,
                        children: [
                          Assets.imagesDaryo.tickCircle.svg(),
                          Expanded(
                            child: tariff.description.s(12).c(context.textSecondary).copyWith(overflow: TextOverflow.ellipsis, softWrap: true),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
