

import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/resource_exts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/currency/currency_code.dart';



class CustomListPriceTextWidget extends StatelessWidget {
  CustomListPriceTextWidget({
    super.key,
    required this.price,
     this.toPrice,
     this.fromPrice,
     this.currency,
    this.color,
    this.size=14,
    this.prefixHint="",
    this.w=500,
    this.textAlign=TextAlign.start
  });

  final num price;
  final int? toPrice;
  final int? fromPrice;
  final CurrencyCode? currency;
  Color? color;
  TextAlign? textAlign;
  final double? size;
  final String? prefixHint;
  final int? w;

 // var f = NumberFormat('###,###');

  //var f = NumberFormat('#,##0.00',"en_US");

  //var format = price is int ? NumberFormat('#,##0', "en_US") : NumberFormat('#,##0.00', "en_US");

  @override
  Widget build(BuildContext context) {
   // var f = NumberFormat('#,##0.00',"en_US");
    var f = price is int ? NumberFormat('#,##0', "en_US") : NumberFormat('#,##0.00', "en_US");

    f.maximumFractionDigits = 2; // Maksimal kasr sonlar soni

    //f.roundingMode = RoundingMode.halfUp; // 0.005 ni yuqoriga yaxlitlash
    String priceStr = (price == 0)
       // ? Strings.priceFrom(price: "${f.format(fromPrice)} ${currency?.getName}")
        ? "$prefixHint${0} ${currency?.getLocalizedName()??""}"
        : "$prefixHint${f.format(price).toString()} ${currency?.getLocalizedName()??""}";
    return priceStr
        .replaceAll(',', ' ')
        .w(w!)
        .s(size!.toDouble())
        .c(color != null ? color! : Color(0xFF5C6AC3))
        .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: textAlign);
  }
}
