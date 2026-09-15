
import 'package:daryo/core/gen/localization/strings.dart';
import 'package:daryo/domain/models/currency/currency_code.dart';



extension CurrencyExtension on CurrencyCode {
  String getLocalizedName() {
    switch (this) {
      case CurrencyCode.uzs:
        return Strings.currencyUzs;
      case CurrencyCode.usd:
        return Strings.currencyUsd;
      case CurrencyCode.eur:
        return Strings.currencyEuro;
      case CurrencyCode.rub:
        return Strings.currencyRuble;
    }
  }
}



