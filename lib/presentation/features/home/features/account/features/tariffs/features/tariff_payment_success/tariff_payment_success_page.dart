import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/router/app_router.dart';
import 'package:daryo/presentation/support/extensions/auto_route_exts.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../../widgets/account/custom_elevated_button.dart';


@RoutePage()
class TariffPaymentSuccessPage extends StatefulWidget {
  const TariffPaymentSuccessPage({super.key});

  @override
  State<TariffPaymentSuccessPage> createState() =>
      _TariffPaymentSuccessPageState();
}

class _TariffPaymentSuccessPageState extends State<TariffPaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // 🔹 Expanded scrollable section (centered content)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.imagesDaryo.tickSuccess.svg(),
                              const SizedBox(height: 20),
                              Text("To'lov muvaffaqiyatli o’tdi!").s(24).w(600),
                              const SizedBox(height: 20),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style:
                                      const TextStyle(color: Color(0xFF6C7278)),
                                  text: "Sizning ",
                                  children: const [
                                    TextSpan(
                                      text: "Daryo 5",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          " tarifiga qilgan to’lovingiz muvaffaqiyatli o’tdi!",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color(0xFFE8FFEB),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("To'lov tafsilotlari").s(16).w(600),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text("Obuna IDsi").c(Color(0xFF6C7278)),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("1450").w(500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Text("To'langan vaqt")
                                            .c(Color(0xFF6C7278)),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child:
                                                Text("2025-09-26 05:00").w(500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Text("Turi").c(Color(0xFF6C7278)),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child:
                                                Text("Donalik tariflar").w(500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Color(0xFFEFF0F6),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text("Umumiy To’lov").s(16).w(600),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("25,000 uzs")
                                                .s(16)
                                                .w(600)
                                                .c(Color(0xFF049C6B)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 🔹 Bottom fixed buttons
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomElevatedButton(
                    text: "Asosiy sahifa",
                    backgroundColor: const Color(0xFF049C6B),
                    onPressed: () {
                      context.router.popUntilOrPushHome(AccountRoute.name);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Barcha huquqlar himoyalangan!")
                          .s(12)
                          .w(500)
                          .c(const Color(0xFF6C7278)),
                      GestureDetector(
                        onTap: () {},
                        child: Text("Ommaviy oferta")
                            .s(12)
                            .w(600)
                            .c(context.colors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
