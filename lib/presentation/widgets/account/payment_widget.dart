import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/data/datasource/network/dto/account/subscriptions/subscriptions_response.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/gen/localization/strings.dart';

class PaymentWidget extends StatefulWidget {
  bool isOpen;
  SubscriptionsListResponse item;
  Function(String) toggleItem;

  PaymentWidget({super.key, required this.isOpen, required this.item, required this.toggleItem});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  bool isExpended = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
            /*gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0F2F1),
              Colors.white,
            ],
          ),*/
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.inputStrokeInactiveColor,
              width: 1,
            ),
            color: context.containerBackground
            /*boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],*/
            ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() {
                  isExpended = !isExpended;
                });
              },
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "ID ${widget.item.id}".s(16).w(500).c(context.textPrimary),
                    AnimatedRotation(
                      turns: isExpended ? 1.0 : 0.75,
                      duration: const Duration(milliseconds: 300),
                      child: Assets.imagesDaryo.icSubscriptionsArrowRight.svg(colorFilter: ColorFilter.mode(context.iconPrimary, BlendMode.srcIn)),
                    ),
                  ],
                ),
              ),
            ),
            if (isExpended)
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: context.inputStrokeInactiveColor,
                  ),
                ),
              ),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: isExpended
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildInfoField(context,Strings.paymentFilterType, widget.item.type_name),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: _buildInfoField(context,Strings.paymentTime, widget.item.order?.create_time ?? ""),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildInfoField(context,Strings.amount, widget.item.post_grainy),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: _buildInfoField(context,Strings.expirationTime, widget.item.order?.create_time ?? ""),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildInfoField(context,Strings.amount, widget.item.post_grainy),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: _buildInfoField(context,Strings.paymentAmount, (widget.item.order?.amount ?? 0).toString()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(BuildContext context,String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.s(10).w(400).c(context.textSecondary),
        const SizedBox(height: 2),
        value.s(14).w(400).c(context.textPrimary),
      ],
    );
  }
}
