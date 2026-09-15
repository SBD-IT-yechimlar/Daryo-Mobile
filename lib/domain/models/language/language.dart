import 'dart:ui';

enum Language {
  uzbekLatin,
  russian,
  english,
  uzbekCyrill;


  String getRestCode() {
    return switch (this) {
      Language.uzbekLatin => "oz",
      Language.russian => "ru",
      Language.english => "en",
      Language.uzbekCyrill => "uz",
    };
  }

  Locale getLocale() {
    return switch (this) {
      Language.uzbekLatin => Locale('uz', 'UZ'),
      Language.russian => Locale('ru', 'RU'),
      Language.english => Locale('en', 'US'),
      Language.uzbekCyrill => Locale('uz', 'UZK'),
    };
  }

  static Language valueOrDefault(String? languageName) {
    return Language.values.firstWhere(
      (e) => e.name.toUpperCase() == languageName?.toUpperCase(),
      orElse: () => Language.uzbekLatin,
    );
  }
}
