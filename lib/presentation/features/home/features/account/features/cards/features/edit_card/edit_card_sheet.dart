import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/colors/static_colors.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:daryo/presentation/support/extensions/mask_formatters.dart';
import 'package:daryo/presentation/widgets/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../../../../../core/gen/localization/strings.dart';
import '../../../../../../../../widgets/button/custom_elevated_button.dart';
import '../../../../../../../../widgets/form_field/custom_text_form_field.dart';
import '../../cards_page.dart';

class EditCardSheet extends StatefulWidget {
  const EditCardSheet({super.key, required this.card});

  final CardModel card;

  static Future<dynamic> show(context, {required CardModel card}) async {
    return showModalBottomSheet(
      // backgroundColor: context.containerBackground,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return EditCardSheet(
          card: card,
        );
      },
    );
  }

  @override
  State<EditCardSheet> createState() => _EditCardSheetState();
}

class _EditCardSheetState extends State<EditCardSheet> {
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cardExpirationDateController;
  late final TextEditingController _cardNameController;
  bool _isMain = false;

  @override
  void initState() {
    super.initState();
    final numberMasked = cardNumberMaskFormatter.formatString(widget.card.cardNumber);
    // final cardExpired =
    //     cardExpiredMaskFormatter.formatString(widget.card.cardExpirationDate);
    _cardNumberController = TextEditingController(text: numberMasked);
    _cardExpirationDateController = TextEditingController(text: widget.card.cardExpirationDate);
    _cardNameController = TextEditingController(text: widget.card.cardName ?? "");
    _isMain = widget.card.isMain;
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardExpirationDateController.dispose();
    _cardNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.backgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
                decoration: BoxDecoration(color: context.iconPrimary, borderRadius: BorderRadius.circular(100)),
              ),
            ),
            SizedBox(height: 24),
            Strings.editCardInformation.s(20).w(600),
            SizedBox(height: 24),
            CustomTextFormField(
              prefixIcon: Assets.imagesDaryo.card.svg(),
              autofillHints: const [AutofillHints.creditCardNumber],
              inputType: TextInputType.number,
              keyboardType: TextInputType.number,
              maxLines: 1,
              hint: Strings.cardNumber,
              textInputAction: TextInputAction.next,
              inputFormatters: cardNumberMaskFormatter,
              controller: _cardNumberController,
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
                  activeColor: StaticColors.white,
                  value: _isMain,
                  onChanged: (value) {
                    setState(() {
                      _isMain = !_isMain;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 8),
            CustomElevatedButton(
                text: Strings.editInformation,
                backgroundColor: context.colors.primary,
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(height: 8),
            CustomElevatedButton(
                backgroundColor: context.redClickColor,
                text: Strings.deleteCard,
                onPressed: () async {
                  final result = await showDialog(
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                            icon: Assets.imagesDaryo.info.svg(),
                            title: "${Strings.diqqat}\n${Strings.deleteCardConfirmation}",
                            subtitle: Strings.areYouSure,
                            actions: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomElevatedButton(
                                  buttonHeight: 40,
                                  text: Strings.confirmDelete,
                                  textColor: context.textPrimary,
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  backgroundColor: context.redClickColor,
                                ),
                                SizedBox(height: 8),
                                CustomElevatedButton(
                                  buttonHeight: 40,
                                  backgroundColor: context.containerBackground,
                                  textColor: context.colors.primary,
                                  text: Strings.cancel,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                      });
                  if (result == true) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                }),
            SizedBox(height: 8),
            CustomElevatedButton(
                backgroundColor: context.containerBackground,
                textColor: context.colors.primary,
                text: Strings.cancel,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
