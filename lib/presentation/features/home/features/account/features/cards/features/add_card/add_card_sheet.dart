import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/support/extensions/mask_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../../../widgets/button/custom_elevated_button.dart';
import '../../../../../../../../widgets/form_field/custom_text_form_field.dart';

class AddCardSheet extends StatefulWidget {
  const AddCardSheet({super.key});

  static Future<dynamic> show(context) async {
    return showModalBottomSheet(
      // backgroundColor: context.containerBackground,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddCardSheet();
      },
    );
  }

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  final _cardNumberController = TextEditingController();
  final _cardExpirationDateController = TextEditingController();
  final _cardNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 14),
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                    color: context.iconPrimary,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            SizedBox(height: 24),
            Strings.addNewCard.s(20).w(600).c(context.textPrimary),
            SizedBox(height: 24),
            CustomTextFormField(
              prefixIcon: Assets.imagesDaryo.card.svg(),
              autofillHints: const [AutofillHints.creditCardNumber],
              inputType: TextInputType.number,
              keyboardType: TextInputType.number,
              maxLines: 1,
              hint: Strings.cardNumber,
              textInputAction: TextInputAction.next,
              controller: _cardNumberController,
              inputFormatters: cardNumberMaskFormatter,
              onChanged: (value) {},
            ),
            SizedBox(height: 24),
            CustomTextFormField(
              prefixIcon: Assets.imagesDaryo.calendar.svg(),
              autofillHints: const [AutofillHints.creditCardExpirationDate],
              inputType: TextInputType.number,
              keyboardType: TextInputType.number,
              maxLines: 1,
              hint: Strings.cardExpiryDate,
              textInputAction: TextInputAction.next,
              controller: _cardExpirationDateController,
              inputFormatters: cardExpiredMaskFormatter,
              onChanged: (value) {},
            ),
            SizedBox(height: 24),
            CustomTextFormField(
              prefixIcon: Assets.imagesDaryo.membership.svg(),
              autofillHints: const [AutofillHints.creditCardName],
              inputType: TextInputType.text,
              keyboardType: TextInputType.text,
              maxLines: 1,
              hint: "${Strings.cardName} (${Strings.optional})",
              textInputAction: TextInputAction.done,
              controller: _cardNameController,
              onChanged: (value) {},
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(Strings.setAsMainCard),
                ),
                Switch(
                  inactiveThumbColor: StaticColors.lightButtonInactiveBorder,
                  activeTrackColor: context.colors.primary,
                  value: true,
                  onChanged: (value) {},
                )
              ],
            ),
            SizedBox(height: 8),
            CustomElevatedButton(
                text: Strings.addCard,
                textColor: context.textPrimary,
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(height: 8),
            CustomElevatedButton(
                backgroundColor: context.containerBackground,
                textColor: context.colors.primary,
                text: Strings.cancel,
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(height: 20.h),

          ],
        ),
      ),
    );
  }
}
